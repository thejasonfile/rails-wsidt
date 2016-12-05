class User < ApplicationRecord
  has_many :restaurants
  has_secure_password
  validates :name, presence: true, uniqueness: true
end
