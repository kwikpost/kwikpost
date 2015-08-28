class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true

  #attr_accessible :rate, :dimension

  validate :no_rate_self

  def no_rate_self
    errors.add(:rateable, "can't rate yourself") if rateable.is_a?(rateable_type) and user.id == rateable.id
  end

end
