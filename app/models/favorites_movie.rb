class FavoritesMovie < ApplicationRecord
  belongs_to :favorite
  belongs_to :movie
end
