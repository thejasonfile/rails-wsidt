class EventsController < ApplicationController
  before_action :authenticate_user

  def create
    results = EventApi.search(params["data"]["zipcode"])
    render json: {movie_info: results}
  end

end
