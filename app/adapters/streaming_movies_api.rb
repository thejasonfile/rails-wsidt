require 'rubygems'
require 'httpclient'
require 'json'

class StreamingMoviesApi

  def callGuideBoxApi
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = "zwpyk7ueg5vce93s98txstwp"
    finalUrl = "https://api-public.guidebox.com/v1.43/all/rKODOSOrXK285VuQitRZe9bdmMnMBpVs/movies/all/1/100/amazon_prime"
    content = clnt.get_content(finalURL)
    @streaming_movies = JSON.parse(content)
    return @streaming_movies
  end

  def search
    results = callGuideBoxApi()
  end

end
