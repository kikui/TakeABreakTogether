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

  def most_dificultless 
    winner = nil
    count = 0
    proposal_ids = self.proposals.map{ |p| p.id }
    self.group.user_groups.each do |ug|
      new_count = Vote.where(user_id: ug.user_id, proposal_id: proposal_ids).count
      winner = ug.user if new_count > count
      count = new_count
    end
    winner.nil? ? "-" : winner.pseudo
  end

  def most_too_late 
    proposal_ids = self.proposals.map { |p| p.id }
    user_ids = self.group.user_groups.map { |ug| ug.user_id }
    vote = Vote.where(user_id: user_ids, proposal_id: proposal_ids).sort_by{ |vote| vote.created_at }.reverse!.first
    vote.nil? ? "-" : vote.user.pseudo
  end

  def user_no_vote
    user_ids = self.group.user_groups.map { |ug| ug.user_id }
    user_ids_voted = Vote.where(user_id: user_ids, proposal_id: self.proposals.map { |p| p.id }).map { |vote| vote.user_id }.uniq
    list = user_ids - user_ids_voted
    list.length > 0 ? User.where(id: list).map{ |user| user.pseudo } : ["-"]
  end

end