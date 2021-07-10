class CreateUserGroup < ActiveRecord::Migration[6.1]
  def change
    create_table :user_groups do |t|
      t.bigint :user_id
      t.bigint :group_id
      t.timestamps
    end
  end
end
