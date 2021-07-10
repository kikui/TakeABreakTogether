class CreateVote < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.bigint :user_id
      t.bigint :proposal_id
      t.timestamps
    end
  end
end
