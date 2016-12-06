class CreateJoinTableFavoriteRestaurant < ActiveRecord::Migration[5.0]
  def change
    create_join_table :favorites, :restaurants do |t|
      # t.index [:favorite_id, :restaurant_id]
      # t.index [:restaurant_id, :favorite_id]
    end
  end
end
