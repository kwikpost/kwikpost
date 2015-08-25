class ChatsController < ApplicationController
  def new

  end

  def create
    @productChat = Productchat.new(user_id: current_user.id, product_id: params[:id])
    

  end

  def update
  end

  def destroy
  end

  def show
  end
end
