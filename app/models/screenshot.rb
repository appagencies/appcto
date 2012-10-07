class Screenshot
  include Mongoid::Document

  embedded_in :app

  mount_uploader :screenshot, ScreenshotUploader

  attr_accessible :screenshot, :screenshot_cache

end
