require_relative '../adapters/movie_api'

class MoviesController < ApplicationController
  skip_before_action :authenticate_user

  def create
    results = MovieApi.new.search(params["data"]["zipcode"])
    # favorited_results = results.select do |result|
    #   result.favorites.where(user_id: find_user_id).length == 1
    # end
    # favorite_ids = favorited_results.map do |result|
    #   result.id
    # end
    byebug
    render json: {movie_info {title: results.title}}
  end

end
