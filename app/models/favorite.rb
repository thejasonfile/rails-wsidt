class Favorite < ApplicationRecord
  belongs_to :user
  has_many :favorites_restaurants
  has_many :restaurants, through: :favorites_restaurants

  validates :rating, inclusion: 1..5
end
