class MoviesController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def show
    user = User.find(params[:id])
    jwt = Auth.issue({user_id: user.id})
    render json: {jwt: jwt}
  end

  def create
    location =
    movie = Movie.new(movie_params)
  end

  def index
    @users = User.all
    render json: @users
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
