class Survey < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :date, presence: true
  validates :day_type, presence: true

  enum day_type_enum: { noon: 'noon', evening: 'evening' }
end