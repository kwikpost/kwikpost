class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])

		@users = User.all
		@follows = @user.follows
		@followmes = UserFollow.includes(:user).where(follow_id: params[:id])
	end

	def follow
		@user = User.find(params[:id])
		@user.user_follows.create(follow: User.find(params[:follow]))
		puts "original_url"
		puts request.original_url
		if params[:product_id]
			puts "product"
			redirect_to product_path(params[:product_id])
		else
			redirect_to user_path(@user.id)
		end
	end

	def unfollow
		@user = User.find(params[:id])
		puts "original_url"
		puts request.original_url
		@user.user_follows.find_by(follow_id: params[:follow]).destroy
		if params[:product_id]
			puts "product"
			redirect_to product_path(params[:product_id])
		else
			redirect_to user_path(@user.id)
		end
	end

	def edit
	end
end
