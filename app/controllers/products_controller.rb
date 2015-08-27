class ProductsController < ApplicationController
  
  def new
    @product = Product.new
  end

  def index 
    # @products = Product.all
    @categories = Category.all
    @products = Product.paginate(:page => params[:page], :per_page => 20)
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
    @following = UserFollow.find_by(user_id: current_user.id, follow_id: @seller.id)
    @followers = UserFollow.where(follow_id: @seller.id)
  end

  def watch
    @watchlist = Watchlist.new(watch_params)
    @watchlist.save
    flash[:notice] = "You successfully added this item to Watchlist"
    flash[:color] = "info"
    redirect_to "/products/#{watch_params[:product_id]}"
  end

  def unwatch
    @user = User.find(current_user.id)
    @watchlist = @user.watchlists.find_by(product_id: watch_params[:product_id])
    @watchlist.destroy
    flash[:notice] = "You successfully removed this item from Watchlist"
    flash[:color] = "info"
    redirect_to "/products/#{watch_params[:product_id]}"
  end



  private
  def product_params
    params.require(:product).permit(:title, :price, :description, :price_fixed, :category_id, :condition_id, :avatar)
  end

  def watch_params
    params.require(:watch).permit(:product_id, :user_id)
  end

end
