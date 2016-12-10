require 'rubygems'
require 'httpclient'
require 'json'

class OnConnectMovieApi

  def callOnConnectAPI(zipcode)
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = "nr4x9rqbtvdv2475g4z4nnbg"
    baseUrl = "http://data.tmsapi.com/v1.1/movies/showings?"
    date = Time.now
    today = onlyDate = date.to_s.split(" ")[0]
    finalURL = baseUrl + "startDate=" + today + "&zip=" + zipcode.to_s + "&api_key=" + apikey;
    content = clnt.get_content(finalURL)
    @movies = JSON.parse(content)
    return @movies
  end

  def findMovies(zipcode)
    results = callOnConnectAPI(zipcode)

    #results.businesses.map do |result|
    end
  end

end
