class ProductsController < ApplicationController
  
  def new
    @product = Product.new
  end

  def index 
    @categories = Category.all
    # @location = Geocoder.search(remote_ip)[0].address
    @location = "Bellevue, WA 98004, United States"
    # Format location for readability
    21.times do
      @location.chop!
    end

    if params[:search_location].present?
      @products = Product.near(params[:search_location], 50).paginate(:page => params[:page], :per_page => 20)
    else
      if params[:category_id]
        @products = Product.where(:category_id => params[:category_id]).paginate(:page => params[:page], :per_page => 20)
        flash[:notice] = Category.find(params[:category_id]).name

      else
        flash[:notice] = nil
        @products = Product.near(@location, 50).paginate(:page => params[:page], :per_page => 20)
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    product = Product.new(product_params)
    product.status = true
    product.user_id = current_user.id
    location = Geocoder.search(remote_ip)
    product.location = location[0].address

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
    @location = "Bellevue, WA 98004, United States"
    # Format location for readability
    21.times do
      @location.chop!
    end
    @product = Product.find(params[:id])
    @products = User.find(@seller.id).products.where.not(id:params[:id])
    @followers = UserFollow.where(follow_id: @seller.id)
    if current_user
      @following = UserFollow.find_by(user_id: current_user.id, follow_id: @seller.id)
    end
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