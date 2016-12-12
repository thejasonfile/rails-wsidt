require 'rubygems'
require 'httpclient'
require 'json'

class MovieApi

  def callOnConnectAPI(zipcode)
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    # apikey = "nr4x9rqbtvdv2475g4z4nnbg"
    apikey = "gvn5q5azch933mbzsgupxer8"
    baseUrl = "http://data.tmsapi.com/v1.1/movies/showings?"
    date = Time.now
    today = date.to_s.split(" ")[0]
    finalURL = baseUrl + "startDate=" + today + "&zip=" + zipcode.to_s + "&api_key=" + apikey;
    content = clnt.get_content(finalURL)
    @movies = JSON.parse(content)
    return @movies
  end

  def search(zipcode)
    results = callOnConnectAPI(zipcode)
    results = results[0..9]
    results.map do |result|
      if !Movie.find_by({tmsId: result['tmsId']}) && !Movie.find_by({showtimes: result['[showtimes]']})
        Movie.create({tmsId: result['tmsId'], title: result['title'], description: result['shortDescription'], genres: result['genres'], showtimes: result['showtimes'], image_url: result['preferredImage']['uri']})
      else
        Movie.find_by({tmsId: result['tmsId']})
      end
    end
    #results.businesses.map do |result|
    #end
  end

end
