class Restaurant < ApplicationRecord
  has_many :favorites_restaurants
  has_many :favorites, through: :favorites_restaurants
end
