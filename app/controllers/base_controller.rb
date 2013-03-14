class BaseController < ApplicationController

	def index

	end

	def image_url
		if request.xhr?
			render json: { image_url: @image_url }
		else
			redirect_to root_path
		end
	end
end