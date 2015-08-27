class UsersController < ApplicationController
	def index
		@products = User.find(params[:id]).products
		@seller = User.find(params[:id])
		@following = UserFollow.find_by(user_id: current_user.id, follow_id: @seller.id)
        @followers = UserFollow.where(follow_id: @seller.id)
	end
	def show
		@user = User.find(params[:id])

		@users = User.all
		@follows = @user.follows
		@followmes = UserFollow.includes(:user).where(follow_id: params[:id])
	end

	def follow
		@user = User.find(params[:id])
		@user.user_follows.create(follow: User.find(params[:follow]))
		redirect_to user_path(@user.id)
	end

	def unfollow
		@user = User.find(params[:id])
		@user.user_follows.find_by(follow_id: params[:follow]).destroy
		redirect_to user_path(@user.id)
	end

	def edit
	end
end
