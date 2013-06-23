class ImageSet
  IMAGE_COUNT = 30

  attr_accessor :images

  def set_images
    self.images ||= []
    thread_image_set(IMAGE_COUNT)
  end

  def thread_image_set(num_times)
    threads = []
    num_times.times do
      threads << Thread.new do
        self.images << RandomImage.new
      end
    end
    threads.each { |th| th.join }
  end

  def has_enough?
    self.images.count >= (IMAGE_COUNT / 2)
  end

  def next_url
    pop_image.url
  end

  def pop_image
    self.images.pop
  end
end