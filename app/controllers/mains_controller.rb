class MainsController < ApplicationController

	def index
	end

	def show

	end

	def posts
		puts "================================="
		render 'mains/posts'
	end
end
