class Restaurant < ApplicationRecord
  # has_many :favorites_restaurants
  # has_many :favorites, through: :favorites_restaurants
  has_many :favorites, as: :favoritable
end
