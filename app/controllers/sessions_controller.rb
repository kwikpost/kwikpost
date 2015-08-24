class SessionsController < Devise::OmniauthCallbacksController
	def facebook
		# You need to implement the method below in your model (e.g. app/models/user.rb)
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			sign_in_and_redirect @user #this will throw if @user is not activated
			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
		else
			puts 'ERRORS STARTING HERE'
			puts @user.errors.to_a
			puts request.env["omniauth.auth"]
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end
end
