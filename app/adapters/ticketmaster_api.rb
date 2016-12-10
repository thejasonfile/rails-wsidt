require 'rubygems'
require 'httpclient'
require 'json'

def TicketmasterAPI

  def callTicketMasterAPI(zipcode)

    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = 'hj2uwyGTN5ZYMJtaullWKKCo0RtmISnt'

    startDate = Time.now
    startTime = startDate.to_s.split(" ")[0] + 'T18:30:00Z'
    endDate = Time.now + (24*60*60)
    endTime = endDate.to_s.split(" ")[0] + 'T8:00:00Z'

    url = 'https://app.ticketmaster.com/discovery/v2/events.json?radius=100&postalCode=' + zipcode.to_s + '&startDateTime=' + startTime + '&endDateTime=' + endTime + '&apikey=' + apikey

    content = clnt.get_content(url)
    content = JSON.parse(content)
    return content

  end

  def getEvents(zipcode)
    results = callTicketmasterAPI(zipcode)

    #results.businesses.map do |result|

  end

end
