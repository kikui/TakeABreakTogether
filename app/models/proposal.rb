class Proposal < ApplicationRecord
  belongs_to :survey
  has_many :votes

  validates :name, presence: true
  validates :address, presence: true

  def find_vote(user_id)
    self.votes.each do |vote|
      return vote if vote.user_id == user_id
    end
  end

end