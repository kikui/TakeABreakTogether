class Survey < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :proposals

  validates :date, presence: true
  validates :day_type, presence: true

  enum day_type_enum: { noon: 'noon', evening: 'evening' }

  def has_vote(user_id)
    voted = false
    self.proposals.each do |proposal|
      proposal.votes.each do |vote|
        voted = true if vote.user_id == user_id
      end
    end
    voted
  end

  def proposal_win 
    selected_proposal = nil
    self.proposals.each do |p|
      selected_proposal = p if selected_proposal.nil? || p.votes.count > selected_proposal.votes.count
    end
    selected_proposal.nil? ? "-" : selected_proposal.name
  end

end