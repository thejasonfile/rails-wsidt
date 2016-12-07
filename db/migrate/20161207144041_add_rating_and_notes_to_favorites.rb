class AddRatingAndNotesToFavorites < ActiveRecord::Migration[5.0]
  def change
    add_column :favorites, :rating, :integer
    add_column :favorites, :notes, :text
  end
end
