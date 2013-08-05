require 'random_image'
class ImageSet
  IMAGE_COUNT = 5

  attr_accessor :images

  def set_images
    self.images ||= []
    fill_image_set(IMAGE_COUNT)
  end

  def fill_image_set(num_times)    
    if Rails.env.development?
      self.images = Image.last(10)
    else 
      num_times.times do
        self.images << RandomImage.new      
      end
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