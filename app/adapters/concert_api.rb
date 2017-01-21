require 'rubygems'
require 'httpclient'
require 'json'

class ConcertApi

  def callJamBaseApi(zipcode)
    proxy = ENV['HTTP_PROXY']
    clnt = HTTPClient.new(proxy)

    apikey = ENV['JAMBASE_KEY']
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
      start_date_time = stringify_time(result['Date'])
      if !Concert.find_by({concert_id: result['Id']})
        artists = result['Artists'].map {|artist| artist["Name"]}.join(', ')
        Concert.create({concert_id: result['Id'], start_time: start_date_time, venue_name: result['Venue']['Name'], venue_address: result['Venue']['Address'], venue_city: result['Venue']['City'], artist: artists, ticket_url: result['TicketUrl']})
      else
        Concert.find_by({concert_id: result['Id']})
      end
    end

  end

  def stringify_time(date_time)

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
