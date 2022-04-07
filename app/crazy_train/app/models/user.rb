class User < ApplicationRecord
  validates :username, presence: true
  validates :hashed_password, presence: true
  has_many :comments
end
