class BaseController < ApplicationController

  before_filter :set_image_set

  def index
    @image_url = @image_set.next_url
  end

  def image_url
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

  private

  def set_image_set
    instantiate_and_set_image_set
  end

  def instantiate_and_set_image_set
    @image_set = ImageSet.new
    @image_set.set_images
  end
end