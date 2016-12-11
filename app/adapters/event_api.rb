require 'rubygems'
require 'eventful/api'
require 'json'

class EventApi

  def self.callEventApi(zipcode)
    eventful = Eventful::API.new 'cdQPghV7xKrjGxdk',
                                :user => 'jake.zappin@gmail.com',
                                :password => 'Flatiron0916'

    events = eventful.call 'events/search',
                          :location => zipcode,
                          :date => 'today',
                          :page_size => 100

    return events
  end

  def self.search(zipcode)
    results = callEventApi(zipcode)
    byebug
    results.map do |result|
      if !Event.find_by({event_id: result['id']}) && !Event.find_by({start_time: result['start_time']})
        Event.create({event_id: result['id'], title: result['title'], description: result['description'], start_time: result['start_time'], url: result['url']})
      else
        Event.find_by({event_id: result['id']})
      end
    end
  end


end
