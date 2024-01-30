class CreateUsersGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :users_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :role

      t.timestamps
      t.index %i[user_id group_id role], unique: true
    end
  end
end
