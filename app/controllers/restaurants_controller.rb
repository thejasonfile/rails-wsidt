class RestaurantsController < ApplicationController
  before_action :authenticate_user

  def create
    results = YelpApi.search(params["data"]["zipcode"])
    render json: {restaurants: results}
  end

end
