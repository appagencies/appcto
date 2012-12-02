class Screenshot
  include Mongoid::Document

  embedded_in :app

  mount_uploader :screenshot, ScreenshotUploader, mount_on: :screenshot

  attr_accessible :screenshot, :screenshot_cache, :remove_screenshot

end
