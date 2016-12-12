class ConcertsController < ApplicationController
  before_action :authenticate_user

  def create
    results = ConcertApi.new.search(params["data"]["zipcode"])
    render json: {concert_info: results}
  end

end
