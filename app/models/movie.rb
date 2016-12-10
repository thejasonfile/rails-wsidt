class Movie < ApplicationRecord
  has_many :favorites, as: :favoritable
end
