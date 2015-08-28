class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def index
    @productcount = Product.all.count
    @categories = Product.group(:category).order("category_id asc").count; #Category.all

    # ======= Hard code because unstable API ======
    @location = "Bellevue, WA 98004, United States"
    # @location = current_location
    # Format location for readability
    21.times do
      @location.chop!
    end
    # =============================================
    @search_coordinates = Geocoder.coordinates(@location)

    if params[:search_location].present?
      puts "============="
      @search_coordinates = Geocoder.coordinates(params[:search_location])
      puts @search_coordinates
      puts "============="
      @products = Product.near(@search_coordinates, 50).paginate(:page => params[:page], :per_page => 20)
      @location = params[:search_location]
      flash[:notice] = params[:search_location]
    else
      if params[:category_id]
        @products = Product.where(:category_id => params[:category_id]).paginate(:page => params[:page], :per_page => 20)
        flash[:notice] = Category.find(params[:category_id]).name
      else
        flash[:notice] = nil
        @products = Product.near(@search_coordinates, 50).paginate(:page => params[:page], :per_page => 20)
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
    @product = Product.includes(:user).find(params[:id])
    @seller = @product.user
    @curuser = current_user
    @rating = Rate.find_by(rater_id: @curuser.id, rateable_id: @seller.id, rateable_type: "User")

    @location = "Bellevue, WA 98004, United States"
    # @location = current_location
    # Format location for readability
    21.times do
      @location.chop!
    end
    @search_coordinates = Geocoder.coordinates(@location)


    @products = @seller.products.where.not(id:params[:id])
    @followers = UserFollow.includes(:user).where(follow_id: @seller.id)
    if @curuser
      @following = @followers.find_by(user_id: @curuser.id)#UserFollow.find_by(user_id: @curuser.id, follow_id: @seller.id)
    end
  end

  def watch
    @watchlist = Watchlist.new(watch_params)
    @watchlist.save
    flash[:notice] = "Watching"
    flash[:color] = "info"
    redirect_to "/products/#{watch_params[:product_id]}"
  end

  def unwatch
    @user = User.find(current_user.id)
    @watchlist = @user.watchlists.find_by(product_id: watch_params[:product_id])
    @watchlist.destroy
    flash[:notice] = "Unwatching"
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
