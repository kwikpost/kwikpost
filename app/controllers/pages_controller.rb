class PagesController < ApplicationController

	def index
		render "pages/#{params[:id]}"
	end

	

end