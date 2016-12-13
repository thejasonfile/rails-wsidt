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

  def getPosterImage(movie_name)

    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    url_movie_name = movie_name.gsub(" ", "%20")
    finalURL= "https://api.themoviedb.org/3/search/movie?api_key=2e2815bcd312a818979f639755782396&language=en-US&query=" + url_movie_name + "&page=1&include_adult=false"
    content = clnt.get_content(finalURL)
    movie = JSON.parse(content)

    posterUri = movie['results'][0]['poster_path']

    finalPosterUri = "https://image.tmdb.org/t/p/w500/" + posterUri
    return finalPosterUri

  end

  def search(zipcode)
    results = callOnConnectAPI(zipcode)
    results = results[0..9]
    movie_poster_uri = getPosterImage(results['title'])
    results.map do |result|
      if !Movie.find_by({tmsId: result['tmsId']}) && !Movie.find_by({showtimes: result['[showtimes]']})
        Movie.create({tmsId: result['tmsId'], title: result['title'], description: result['shortDescription'], genres: result['genres'], showtimes: result['showtimes'], image_url: movie_poster_uri})
      else
        Movie.find_by({tmsId: result['tmsId']})
      end
    end

  end

end
