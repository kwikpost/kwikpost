class UserFollow < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :follow, class_name: 'User'

  validates :user, :follow, presence: true
  validate :no_follow_self

  def no_follow_self
    errors.add(:follow, "can't follow yourself") if user == follow
  end
end
