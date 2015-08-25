class Productchat < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  has_many :chats, dependent: :destroy
end
