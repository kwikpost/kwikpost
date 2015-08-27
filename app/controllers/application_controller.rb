class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def remote_ip
    if request.remote_ip == '127.0.0.1'
     '2601:600:8a00:d600:95e8:9fdd:205f:3850'
    else
      request.remote_ip
    end
  end

  private
  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  helper_method :mailbox, :conversation

  private
  def mailbox
    @mailbox ||= current_user.mailbox
  end

end
