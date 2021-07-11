class User < ApplicationRecord
  has_secure_password

  has_many :user_groups
  has_many :surveys
  has_many :groups
  has_many :votes

  validates :email, uniqueness: true, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :password_digest, presence: true
  validates :pseudo, presence: true

  def user_groups_whithout_my_groups 
    self.user_groups.where.not(user_id: self.id)
  end

  def user_surveys 
    surveys = []
    self.user_groups.each do |ug|
      ug.group.surveys.each do |s|
        datetime_survey = s.date.to_datetime.change({ hour: s.day_type == Survey.day_type_enums[:noon] ? 14 : 21, min: 0, sec: 0 }).in_time_zone
        surveys << s if datetime_survey > DateTime.now.in_time_zone
      end
    end 
    surveys
  end

  def user_history_surveys
    surveys = []
    self.user_groups.each do |ug|
      ug.group.surveys.each do |s|
        datetime_survey = s.date.to_datetime.change({ hour: s.day_type == Survey.day_type_enums[:noon] ? 14 : 21, min: 0, sec: 0 }).in_time_zone
        surveys << s if datetime_survey < DateTime.now.in_time_zone
      end
    end 
    surveys
  end

end