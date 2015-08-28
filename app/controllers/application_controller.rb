class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def remote_ip
    if request.remote_ip == '127.0.0.1'
     '2601:602:8201:ded0:4016:1d49:7f23:9686'
    else
      request.remote_ip
    end
  end

  def current_location
    @location ||= Geocoder.search(remote_ip)[0].address
  end

  private
  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  helper_method :mailbox, :conversation

end
