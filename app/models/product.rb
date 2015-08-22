class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :condition
end
