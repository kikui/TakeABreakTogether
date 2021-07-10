class Vote < ApplicationRecord
  belongs_to :Proposal
  belongs_to :user
end