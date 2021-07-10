class Group < ApplicationRecord
  has_many :user_groups
  has_many :surveys
  belongs_to :user

  validates :name, presence: true
end