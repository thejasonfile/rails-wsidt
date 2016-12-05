class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user

  def index
    byebug
  end

  def create
    user_id = Auth.decode(params["data"]["jwt"])[0]["user_id"]
    YelpApi.search(params["data"]["zipcode"], user_id)
    render json: {restaurants: Restaurant.all, user_id: user_id}
  end

end
