class Image < ActiveRecord::Base
  def hash
    self.url.split('/').last.gsub(/\..*/, '')
  end
end