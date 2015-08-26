class MainsController < ApplicationController
	def index
		@products = Product.paginate(page: params[:page], per_page: 20).order('created_at DESC')
		if request.xhr?
			render :partial=>"product_list"
		end
		# Product.all.order(created_at: :desc)
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

	def create
		product = Product.new(product_params)
		# product.price_fixed = params.require(:product)[:price_fixed]
		product.status = true
		product.user_id = current_user.id

		if product.save
			flash[:errors] = ["Successfully added a new product!"]
		else
			flash[:errors] = product.errors.full_messages
		end
		redirect_to "/mains/#{current_user.id}/posts"
	end
	def product_params
		params.require(:product).permit(:title, :price, :description, :price_fixed, :category_id, :condition_id, :avatar)
	end
end
