class User < ApplicationRecord
  has_secure_password

  has_many :user_groups
  has_many :surveys
  has_many :groups
  has_many :votes

  validates :email, uniqueness: true, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :password_digest, presence: true
  validates :pseudo, presence: true

end