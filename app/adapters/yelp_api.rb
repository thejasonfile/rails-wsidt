class YelpApi

  def self.client
    @client ||= Yelp::Client.new({
      consumer_key: 'rCPjCJMrMc2naKiFJG1OuQ',
      consumer_secret: '1vNPcyEIxqJPrtJwO4Xc5U59HNE',
      token: 'SJmlEkBKLgtC6WMzsZAeWxQrMwUUIaKr',
      token_secret: 'mmTFFzz8rlBGGn_dQvsqDHuOfcs'
      })
  end

  def self.search(zipcode, user_id)
    # Restaurant.where(user_id: user_id).destroy_all
    results = client.search(zipcode)
    results.businesses.map do |result|
      Restaurant.find_or_create_by({name: result.name, rating: result.rating, address: result.location.address.join(", "), city: result.location.city, zipcode: result.location.postal_code, url: result.url, user_id: user_id})
    end
  end

end
