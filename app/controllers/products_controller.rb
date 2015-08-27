class ProductsController < ApplicationController
  
  def new
    @product = Product.new
  end

  def index 
    @products = Product.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    product = Product.new(product_params)
    product.status = true
    product.user_id = current_user.id

    if product.save
      flash[:errors] = ["Successfully added a new product!"]
    else
      flash[:errors] = product.errors.full_messages
    end
    redirect_to "/mains/#{current_user.id}/posts"
  end

  def update
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
  end

  def show
    @product = Product.find(params[:id])
    @followers = UserFollow.where(user_id:current_user.id)
    @followings = UserFollow.where(follow_id: current_user.id )
  end

  private
  def product_params
    params.require(:product).permit(:title, :price, :description, :price_fixed, :category_id, :condition_id, :avatar)
  end

end
