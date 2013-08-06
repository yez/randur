class RandomImage
  include HTTParty

  attr_accessor :hash, :url

  def initialize
    set_url
  end

  def set_url
    self.url = if Rails.env.development?
      Image.last.url
    elsif hash_from_random_fetch
      img = Image.where(url: "http://i.imgur.com/#{self.hash}.jpg").first_or_create
      img.url
    end
  end

  def random_fetch_url
    "http://imgur.com/gallery/random"
  end

  def hash_from_random_fetch
    puts "fetching #{random_fetch_url}"
    response = HTTParty.get(random_fetch_url)
    match = response.body.match /hash":"([^"]+)/
    self.hash = match[1] if match
  end
end