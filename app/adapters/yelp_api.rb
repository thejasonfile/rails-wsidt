class YelpApi

  def self.client
    @client ||= Yelp::Client.new({
      # consumer_key: ENV['YELP_CONSUMER_KEY'],
      # consumer_secret: ENV['YELP_CONSUMER_SECRET'],
      # token: ENV['YELP_TOKEN'],
      # token_secret: ENV['YELP_TOKEN_SECRET']
      consumer_key: 'tDim-oA5sggT_lV1shpe8g',
      consumer_secret: 'fxHaI-QTjueMgfrede8x3SFmm5Y',
      token: 'r9vayQto-j_nGd-3a6oKaIBfxG-q1yCu',
      token_secret: 'LTyyGzA5HpBI8_cUv6Sb53rhf-w'
      })
  end

  def self.search(zipcode, term)
    results = client.search(zipcode, term)
    results.businesses.map do |result|
      if !Restaurant.find_by({yelp_id: result.id})
        categories = result.categories.map {|category| category[0]}.join(', ')
        Restaurant.create({yelp_id: result.id, name: result.name, address: result.location.address.join(", "), city: result.location.city, zipcode: result.location.postal_code, phone: result.display_phone, url: result.url, rating:result.rating, categories: categories, image: result.image_url})
      else
        Restaurant.find_by({yelp_id: result.id})
      end
    end
  end

end
