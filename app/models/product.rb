class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  has_many :watchlists
  # has_many :users, :through => :watchlist
end
