require 'random_image'
class ImageSet
  IMAGE_COUNT = 5

  attr_accessor :images

  def self.build_from_session(urls)
    set = ImageSet.new
    set.images = [].tap do |img_arr|
      urls.each do |url|
        img_arr << Image.where(url: url).first
      end
    end
    set
  end

  def set_images
    self.images ||= []
    fill_image_set(IMAGE_COUNT)
  end

  def fill_image_set(num_times)
    num_times.times do
      self.images << RandomImage.new
    end
  end

  def has_enough?
    self.images.count >= (IMAGE_COUNT / 2)
  end

  def next_url
    pop_image.try(:url)
  end

  def pop_image
    self.images.pop
  end
end