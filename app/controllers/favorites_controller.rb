class FavoritesController < ApplicationController
  before_action :authenticate_user

  def create
    Favorite.find_or_create_by(user_id: find_user_id, favoritable: Restaurant.find(params["restaurant"]["id"]))
  end

  def destroy
    Favorite.find_by(user_id: find_user_id, favoritable: Restaurant.find(params["restaurant"]["id"])).destroy
  end

  def find_user_id
    Auth.decode(request.env["HTTP_AUTHORIZATION"])[0]["user_id"]
  end

end
