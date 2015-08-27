class MainsController < ApplicationController
	def index
		@products = Product.all.order(created_at: :desc)
		@categories = Category.all
	end

	def show

	end

	def posts
		@product = Product.new
		@products = Product.where(user_id: current_user.id)
		@conditions = Condition.all
		@categories = Category.all
	end


end
