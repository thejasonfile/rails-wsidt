require 'rubygems'
require 'eventful/api'
require 'json'

class EventApi

  def self.callEventApi(zipcode)
    eventful = Eventful::API.new 'cdQPghV7xKrjGxdk',
                                :user => 'jake.zappin@gmail.com',
                                :password => 'Flatiron0916'
    # eventful = Eventful::API.new 'BJj4zbJ4MfZtpG2q',
    #                             :user => 'salomekbg@gmail.com',
    #                             :password => 'WTFSIDT0916'

    events = eventful.call 'events/search',
                          :location => zipcode,
                          :date => 'today',
                          :within => 25,
                          :units => 'mi',
                          :categories => 'comedy, plays, broadway, music, shows',
                          :page_size => 100

    return events
  end

  def self.search(zipcode)
    results = callEventApi(zipcode)
    results['events']['event'].map do |result|
      start_date_time = stringify_time(result['start_time'])
      sanitized_description = ActionView::Base.full_sanitizer.sanitize(result['description'])
      if(sanitized_description != nil)
        sanitized_description.gsub("<br>", " ")
        sanitized_description.gsub("&#39;s", "'")
        sanitized_description.gsub("&amp", " ")
        sanitized_description.gsub("&quot;", "'")
        sanitized_description[0].capitalize
      end
      puts sanitized_description
      result['image'] != nil ? img_url = result['image']['medium']['url'] : img_url = "https://s28.postimg.org/gwri9yx1p/no_img.jpg"
      if !Event.find_by({event_id: result['id']}) && !Event.find_by({start_time: result['start_time']})
        Event.create({event_id: result['id'], title: result['title'], description: sanitized_description, start_time: start_date_time, url: result['url'], image_url: img_url})
      else
        Event.find_by({event_id: result['id']})
      end
    end
  end

  def self.stringify_time(date_time)

    date_time = date_time.to_s
    if date_time.include? "T"
      date = date_time.split("T").first
      time = date_time.split("T").last
    else
      date = date_time.split(" ").first
      time = date_time.split(" ")[1]
    end

    year = date.split("-").first
    month = date.split("-")[1]
    day = date.split("-").last
    final_date = month + "-" + day + "-" + year

    hour = time.split(":").first
    am_pm = ""
    if hour.to_i >= 12
      am_pm = "p.m."
    else
      am_pm = "a.m."
    end

    if hour == "13"
      hour = "1"
    elsif hour == "14"
      hour = "2"
    elsif hour == "15"
      hour = "3"
    elsif hour == "16"
      hour = "4"
    elsif hour == "17"
      hour = "5"
    elsif hour == "18"
      hour = "6"
    elsif hour == "19"
      hour = "7"
    elsif hour == "20"
      hour = "8"
    elsif hour == "21"
      hour = "9"
    elsif hour == "22"
      hour = "10"
    elsif hour == "23"
      hour = "11"
    elsif hour == "24"
      hour = "12"
    end

    minutes = time.split(":")[1]
    final_time = hour + ":" + minutes + am_pm

    final_date_time = final_time + " " + final_date

    return final_date_time

  end

end
