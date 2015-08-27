class ChatsController < ApplicationController

  def new

    @productChat = Productchat.find_by(user_id: current_user.id, product_id: params[:product_id])  
    
    if @productChat
    
      @product = Product.find(params[:product_id])
      @chats = @productChat.chats.all
    
    else
    
      @product = Product.find(params[:product_id])   
    
    end
  end

  def create
    @product = Product.find(chat_params["product_id"])
    @productChat = @product.productchats.find_by(user_id: current_user.id)

    if @productChat

      @chat = @productChat.chats.new(user_id: chat_params["user_id"], message: chat_params["message"])

    else

      @productChat = Productchat.new(user_id: current_user.id, product_id: chat_params["product_id"])
      @productChat.save
      @chat = @productChat.chats.new(user_id: chat_params["user_id"], message: chat_params["message"])

    end
    
      @chat.save
      flash[:notice] = "Your message has been sent"
      flash[:color] = "success"
      redirect_to "/products/#{@product.id}"
  end

  def update
  end

  def destroy
  end

  def show
  end

  def chat_params
    params.require(:chat).permit(:message, :user_id, :product_id)
  end
end
