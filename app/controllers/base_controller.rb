class BaseController < ApplicationController

  before_filter :set_image_set

  def index
    @image_url = @image_set.next_url
  end

  def image_url
    if !!request.xhr?
      render json: { image_url: @image_set.next_url, hash: @image_set.next_hash }
      unless @image_set.has_enough?
        @image_set.set_images
      end
    else
      redirect_to root_path
    end
  end

  private

  def set_image_set
    pop_image_session
    if session[:image_urls].present?
      @image_set = ImageSet.build_from_session(session[:image_urls])
    else
      instantiate_and_set_image_set
    end
  end

  def instantiate_and_set_image_set
    @image_set = ImageSet.new
    @image_set.set_images
    session[:image_urls] = @image_set.images.collect(&:url)
  end

  def pop_image_session
    if session[:image_urls].present?
      image_urls = session[:image_urls]
      image_urls.shift
      session[:image_urls] = image_urls
    end
  end
end