class CreateSurvey < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|
      t.date :date
      t.string :day_type
      t.bigint :group_id
      t.bigint :user_id
      t.timestamps
    end
  end
end
