class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    all_user_favorites = Favorite.all.where(user_id: find_user_id)
    favObject = all_user_favorites.map do |favorite|
      [favorite, favorite.favoritable]
    end.sort!
    render json: {favorites: favObject}
  end

  def create
    Favorite.find_or_create_by(user_id: find_user_id, favoritable: Restaurant.find(params["restaurant"]["id"]))
  end

  def update
    favorite = Favorite.find(params[:id])
    favorite.update(rating: params[:favorite][:rating], note: params[:favorite][:notes])
    # render json: {favorite: favorite}
    all_user_favorites = Favorite.all.where(user_id: find_user_id)
    favObject = all_user_favorites.map do |favorite|
      [favorite, favorite.favoritable]
    end.sort!
    render json: {favorites: favObject}
  end

  def destroy
    Favorite.find_by(user_id: find_user_id, favoritable: Restaurant.find(params["restaurant"]["id"])).destroy
  end

  private

  def find_user_id
    Auth.decode(request.env["HTTP_AUTHORIZATION"])[0]["user_id"]
  end

end
