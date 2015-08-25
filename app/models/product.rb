class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  has_many :watchlists
  has_attached_file :avatar

  validates :title, :price, :description, :condition_id, :price_fixed, :category_id, presence: true
  validates :avatar, attachment_presence: true
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
