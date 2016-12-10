require 'rubygems'
require 'eventful/api'
require 'json'

class EventfulApi

  def callEventfulApi(zipcode)
    eventful = Eventful::API.new 'cdQPghV7xKrjGxdk',
                                :user => 'jake.zappin@gmail.com',
                                :password => 'Flatiron0916'

    events = eventful.call 'events/search',
                          :location => zipcode,
                          :date => 'tomorrow',
                          :page_size => 100

    return events
  end

  def getEvents(zipcode)
    results = callEventfulAPI(zipcode)

    #results.businesses.map do |result|

  end


end
