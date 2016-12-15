require 'rubygems'
require 'httpclient'
require 'json'

class StreamingShowsApi

  def callGuideBoxApi
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = "zwpyk7ueg5vce93s98txstwp"
    finalUrl = "https://api-public.guidebox.com/v1.43/all/rKODOSOrXK285VuQitRZe9bdmMnMBpVs/shows/all/1/25/amazon_prime"
    content = clnt.get_content(finalUrl)
    @streaming_shows = JSON.parse(content)
    return @streaming_shows
  end

  def search
    results = callGuideBoxApi()
    results['results'][0..4].map do |result|
      url = 'http://thetvdb.com/?tab=series&id=' + result['tvdb'].to_s
      if !StreamingShow.find_by({show_id: result['id']})
        StreamingShow.create({show_id: result['id'], title: result['title'], first_aired: result['first_aired'], image: result['artwork_304x171'], url: url})
      else
        StreamingShow.find_by({show_id: result['id']})
      end
    end
  end

end
