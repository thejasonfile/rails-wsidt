require 'rubygems'
require 'httpclient'
require 'json'

class StreamingShowsApi

  def callGuideBoxApi
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = "zwpyk7ueg5vce93s98txstwp"
    finalUrl = "https://api-public.guidebox.com/v1.43/all/rKODOSOrXK285VuQitRZe9bdmMnMBpVs/shows/all/1/25/amazon_prime"
    content = clnt.get_content(finalURL)
    @streaming_shows = JSON.parse(content)
    return @streaming_shows
  end

  def search
    results = callGuideBoxApi()
  end

end
