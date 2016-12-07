class RestaurantsController < ApplicationController
  before_action :authenticate_user

  def create
    user_id = Auth.decode(params["data"]["jwt"])[0]["user_id"]
    results = YelpApi.search(params["data"]["zipcode"])
    render json: {restaurants: results}
  end

end
