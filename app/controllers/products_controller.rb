class ProductsController < ApplicationController
  
  def new
    @product = Product.new
  end

  def index 
    # @products = Product.all
    @categories = Category.all
    @products = Product.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    respond_to do |format|
      format.html 
      format.js
    end
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
    @seller = Product.find(params[:id]).user
    @product = Product.find(params[:id])
    @products = User.find(@seller.id).products
    @followers = UserFollow.where(follow_id: @seller.id)
    if current_user
      @following = UserFollow.find_by(user_id: current_user.id, follow_id: @seller.id)
    end
  end

  private
  def product_params
    params.require(:product).permit(:title, :price, :description, :price_fixed, :category_id, :condition_id, :avatar)
  end

end
