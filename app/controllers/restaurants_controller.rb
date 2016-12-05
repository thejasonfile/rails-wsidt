class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user

  def index
    byebug
  end

  def create
    byebug
    YelpApi.search(zipcode)
  end

end
