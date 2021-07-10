class CreateProposal < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :address
      t.bigint :survey_id
      t.timestamps
    end
  end
end
