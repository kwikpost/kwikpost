class MainsController < ApplicationController
	def index
		# @categories = Category.all
		# @products = Product.paginate(page: params[:page], per_page: 20).order('created_at DESC')
		# respond_to do |format|
		# 	format.html
		# 	format.js
		# end
		# # Product.all.order(created_at: :desc)
		
	end

	def show

	end

	def posts
		@product = Product.new
		@products = Product.where(user_id: current_user.id)
		@user_chats = Productchat.where(user_id: current_user.id)
		@conditions = Condition.all
		@categories = Category.all
		@followings = UserFollow.where(user_id:current_user.id)
	    @followers = UserFollow.where(follow_id:current_user.id)
	end


end
