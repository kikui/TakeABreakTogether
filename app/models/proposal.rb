class Proposal < ApplicationRecord
  belongs_to :survey
  has_many :votes

  validates :name, presence: true
  validates :address, presence: true
end