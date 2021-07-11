class Group < ApplicationRecord
  has_many :user_groups
  has_many :surveys
  belongs_to :user

  validates :name, presence: true

  def check_user_already_present(user)
    self.user_groups.each do |ug|
      return true if ug.user == user
    end
    return false
  end

  def user_group(user_id) 
    self.user_groups.select{ |ug| ug.user_id == user_id }.first
  end

end