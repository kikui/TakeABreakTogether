class Proposal < ApplicationRecord
  belongs_to :survey
  has_many :votes

  validates :name, presence: true
  validates :address, presence: true

  def find_vote(user_id)
    selected_vote = nil
    self.votes.each do |vote|
      selected_vote = vote if vote.user_id == user_id
    end
    selected_vote
  end

end