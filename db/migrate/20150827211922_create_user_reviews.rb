class CreateUserReviews < ActiveRecord::Migration
  def change
    create_table :user_reviews do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :reviewuser_id, index: true, foreign_key: true
      t.integer :rating
      t.text :review
      t.text :reply

      t.timestamps null: false
    end
  end
end
