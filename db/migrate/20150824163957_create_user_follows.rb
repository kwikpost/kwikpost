class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :follow_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
