class FavoritesController < ApplicationController

  def create
    user_id = Auth.decode(params["user"]["jwt"])[0]["user_id"]
    Favorite.create(user_id: user_id, favoritable: Restaurant.find(params["restaurant"]["id"]))
  end

  def destroy
    byebug
  end

end
