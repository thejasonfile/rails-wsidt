class BarsController < ApplicationController
  before_action :authenticate_user

  def create
    results = YelpApi.search(params["data"]["zipcode"], {term: 'bar'})
    favorited_results = results.select do |result|
      result.favorites.where(user_id: find_user_id).length == 1
    end
    favorite_ids = favorited_results.map do |result|
      result.id
    end
    render json: {bars: results, favorited_ids: favorite_ids}
  end

  private

  def find_user_id
    Auth.decode(request.env["HTTP_AUTHORIZATION"])[0]["user_id"]
  end

end
