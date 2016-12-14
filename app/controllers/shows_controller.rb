class ShowsController < ApplicationController
  before_action :authenticate_user

  def create
    byebug
    shows = StreamingShowsApi.new.search
    movies = StreamingMoviesApi.new.search
    render json: {shows_results: shows, movies_results: movies}
  end

end
