class FavoritesController < ApplicationController

  def create
    user_id = Auth.decode(params["user"]["jwt"])[0]["user_id"]
    Favorite.find_or_create_by(user_id: user_id, favoritable: Restaurant.find(params["restaurant"]["id"]))
  end

  def destroy
    byebug
  end

end
