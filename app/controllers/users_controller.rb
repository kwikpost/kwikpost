class UsersController < ApplicationController
	def index
		@curuser = current_user;
		@seller = User.find(params[:id])
		@products = @seller.products
		@product = @products.last
		@followers = UserFollow.where(follow_id: @seller.id)
		@following = @followers.find_by(user_id: @curuser.id)
		@rating = Rate.find_by(rater_id: @curuser.id, rateable_id: params[:id], rateable_type: "User")
	end
	def show
		# Testing purpose
		@user = User.find(params[:id])

		@users = User.all.includes(:user_reviews)
		@follows = @user.follows
		@followmes = UserFollow.includes(:user).where(follow_id: params[:id])
		@myreviews = UserReview.includes(:user).where(user_id: params[:id])
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

	def review
		fail
		@reviewer = current_user
		@user = User.find(params[:id])

		# if user_reviews.find_by(reviewuser_id: @reviewer)
		@user.user_reviews.create(reviewuser: @reviewer.id, review: params[:review])

		redirect_to user_path(params[:user_id])
	end

	def edit
	end
end
