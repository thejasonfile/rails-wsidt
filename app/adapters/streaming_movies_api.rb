require 'rubygems'
require 'httpclient'
require 'json'

class StreamingMoviesApi

  def callGuideBoxApi
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = ENV["GUIDEBOX_KEY"]
    finalUrl = "https://api-public.guidebox.com/v1.43/all/rKODOSOrXK285VuQitRZe9bdmMnMBpVs/movies/all/1/25/amazon_prime"
    content = clnt.get_content(finalUrl)
    @streaming_movies = JSON.parse(content)
    return @streaming_movies
  end

  def search
    results = callGuideBoxApi()
    results['results'][0..4].map do |result|
      if !StreamingMovie.find_by({movie_id: result['id']})
        StreamingMovie.create({movie_id: result['id'], title: result['original_title'], release_date: result['release_date'], rating: result['rating'], image: result['poster_240x342'], url: result['metacritic']})
      else
        StreamingMovie.find_by({movie_id: result['id']})
      end
    end
  end

end
