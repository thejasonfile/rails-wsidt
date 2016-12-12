require 'rubygems'
require 'httpclient'
require 'json'

class ConcertApi

  def callJamBaseApi(zipcode)
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = "zwpyk7ueg5vce93s98txstwp"
    baseUrl = "http://api.jambase.com/events?"
    date = Time.now
    today = date.to_s.split(" ")[0]
    finalURL = baseUrl + "zipCode=" + zipcode + "&radius=50&startDate=" + today + "T16:00:00&endDate=" + today + "T23:59:00" + "&page=0&api_key=" + apikey
    content = clnt.get_content(finalURL)
    @concerts = JSON.parse(content)
    return @concerts
  end

  def search(zipcode)
    results = callJamBaseApi(zipcode)
    results['Events'].map do |result|
      byebug
      if !Concert.find_by({concert_id: result['Id']})
        Concert.create({concert_id: result['Id'], date: result['Date'], venue_name: result['Venue']['Name'], venue_address: result['Venue']['Address'], venue_city: result['Venue']['City'], artist: result['Artist']['Name'], url: result['TicketUrl']})
      else
        Concert.find_by({concert_id: result['Id']})
      end
    end
    #results.map do |result|
    #  if !Movie.find_by({tmsId: result['tmsId']}) && !Movie.find_by({showtimes: result['[showtimes]']})
    #    Movie.create({tmsId: result['tmsId'], title: result['title'], description: result['shortDescription'], genres: result['genres'], showtimes: result['showtimes'], image_url: result['preferredImage']})
    #  else
    #    Movie.find_by({tmsId: result['tmsId']})
    #  end
    #end
    #results.businesses.map do |result|
    #end
  end

end
