class BaseController < ApplicationController

  before_filter :set_image_set

	def index
    @image_url = @image_set.next_url
	end

	def image_url
    measurement = Benchmark.measure do
    @image_url = @image_set.next_url
		if request.xhr?
			render json: { image_url: @image_url }
      unless @image_set.has_enough?
        @image_set.set_images
      end
		else
			redirect_to root_path
		end
    end
    puts measurement
	end

  private

  def set_image_set
    if session[:image_set]
      @image_set = session[:image_set]
    else
      instantiate_and_set_image_set
    end
  end

  def instantiate_and_set_image_set
    @image_set = ImageSet.new
    @image_set.set_images
    session[:image_set] = @image_set
  end
end