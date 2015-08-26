class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  has_many :watchlists, dependent: :destroy
  has_many :productchats, dependent: :destroy
  has_many :chats, through: :productchat

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", large: "600x600" }
  validates :title, :price, :description, :condition_id, :category_id, presence: true
  validates :price_fixed, inclusion: [true, false]
  validates :avatar, attachment_presence: true
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  self.per_page = 10

end
