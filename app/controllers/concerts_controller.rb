class ConcertsController < ApplicationController
  before_action :authenticate_user

  def create
    byebug
    results = ConcertApi.new.search(params["data"]["zipcode"])
    render json: {concert_info: results}
  end

end
