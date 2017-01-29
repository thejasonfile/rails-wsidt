require 'rubygems'
require 'httpclient'
require 'json'

class MovieApi

  def callOnConnectAPI(zipcode)
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = ENV["ONCONNECT_KEY"]
    baseUrl = "http://data.tmsapi.com/v1.1/movies/showings?"
    date = Time.now
    today = date.to_s.split(" ")[0]
    finalURL = baseUrl + "startDate=" + today + "&zip=" + zipcode.to_s + "&api_key=" + apikey;
    content = clnt.get_content(finalURL)
    content.length == 0 ? @movies = [] : @movies = JSON.parse(content)
    return @movies
  end

  def get_image(movie_name)

    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    uri_movie_name = movie_name.gsub(" ", "%20")
    api_uri= "https://api.themoviedb.org/3/search/movie?api_key=2e2815bcd312a818979f639755782396&language=en-US&query=" + uri_movie_name + "&page=1&include_adult=false"
    content = clnt.get_content(api_uri)
    movie = JSON.parse(content)
    if movie['results'][0] == nil
      return "NO IMAGE"
    else
      poster_uri = movie['results'][0]['poster_path']
      final_uri= "https://image.tmdb.org/t/p/w500/" + poster_uri
      return final_uri
    end

  end

  def search(zipcode)
    results = callOnConnectAPI(zipcode)
    results = results[0..9]
    results.map do |result|
      if !Movie.find_by({tmsId: result['tmsId']}) && !Movie.find_by({showtimes: result['[showtimes]']})
        movie_image = get_image(result['title'])
        Movie.create({tmsId: result['tmsId'], title: result['title'], description: result['shortDescription'], genres: result['genres'], showtimes: result['showtimes'], image_url: movie_image})
      else
        Movie.find_by({tmsId: result['tmsId']})
      end
    end

  end

end
