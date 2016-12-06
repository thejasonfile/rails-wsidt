class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user

  def index
    byebug
  end

  def create
    user_id = Auth.decode(params["data"]["jwt"])[0]["user_id"]
    results = YelpApi.search(params["data"]["zipcode"])
    render json: {restaurants: results}
  end

end
