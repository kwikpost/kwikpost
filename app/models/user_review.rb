class UserReview < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :reviewuser, class_name: 'User'

  validates :user, :reviewuser, :review, presence: true
  validate :no_review_self

  def no_review_self
    errors.add(:reviewuser, "can't review yourself") if user == reviewuser
  end

end
