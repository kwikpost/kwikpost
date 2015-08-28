class RemoveRatingFromUserReviews < ActiveRecord::Migration
  def change
    remove_column :user_reviews, :rating, :integer
  end
end
