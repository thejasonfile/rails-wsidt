require_relative '../adapters/movie_api'

class MoviesController < ApplicationController
  before_action :authenticate_user

  def create
    results = MovieApi.new.search(params["data"]["zipcode"])
    render json: {movie_info: results}
  end

end
