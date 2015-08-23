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

  end

  private
  def product_params

  end
end
