class EventsController < ApplicationController
  before_action :authenticate_user

  def create
    results = EventApi.search(params["data"]["zipcode"])
    render json: {event_info: results}
  end

end
