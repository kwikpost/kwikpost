class ChatsController < ApplicationController

  def index

    @products = current_user.products
    ids = Array[]
    @products.each do |p|
      ids.push(p.id)
    end 

    @productchats = Productchat.where('product_id IN (?)', ids).order(created_at: :desc)

  end


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

  def buy
    @product = Product.find(chat_params["product_id"])
    @productChat = @product.productchats.find_by(user_id: current_user.id)

    if @productChat

      @chat = @productChat.chats.new(user_id: chat_params["user_id"], message: chat_params["message"])
      @chat.message = "You have been offered #{chat_params["message"]} for your product"

    else

      @productChat = Productchat.new(user_id: current_user.id, product_id: chat_params["product_id"])
      @productChat.save
      @chat = @productChat.chats.new(user_id: chat_params["user_id"], message: chat_params["message"])
      @chat.message = "You have been offered #{chat_params["message"]} for your product"

    end
    
      @chat.save
      flash[:notice] = "Your offer has been sent"
      flash[:color] = "success"
      redirect_to "/products/#{@product.id}"
   
  end

  def reply
     @productChat = Productchat.find(reply_params[:productchat_id])
     @chat = @productChat.chats.new(user_id: reply_params[:user_id], message: reply_params[:message])
     @chat.save
     redirect_to "/chats/show/#{@productChat.id}"
    
  end

  def show
    @productchats = Productchat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:message, :user_id, :product_id)
  end
  def reply_params
    params.require(:reply).permit(:message, :user_id, :productchat_id)
    
  end
end
