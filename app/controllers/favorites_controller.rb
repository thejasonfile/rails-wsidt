class FavoritesController < ApplicationController
  before_action :authenticate_user

  def create
    user_id = Auth.decode(params["user"]["jwt"])[0]["user_id"]
    Favorite.find_or_create_by(user_id: user_id, favoritable: Restaurant.find(params["restaurant"]["id"]))
  end

  def destroy
    user_id = Auth.decode(params["user"]["jwt"])[0]["user_id"]
    Favorite.find_by(user_id: user_id, favoritable: Restaurant.find(params["restaurant"]["id"])).destroy
  end

end
