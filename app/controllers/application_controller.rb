class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :build_image_url

  private

  def build_image_url
  	@image_url ||= "http://i.imgur.com/#{get_random}.jpg"
  end

  def get_random
  	url = "http://imgur.com/gallery/random"
  	response = HTTParty.get(url)
  	hash_from_source(response.body)
	end

	#"hash":"ciIUu"
	def hash_from_source(body)
  	match = body.match /hash":"([^"]+)/
 	 match[1] if match
	end
end
