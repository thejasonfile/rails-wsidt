class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :favorites
  has_many :restaurants, through: :favorites

end
