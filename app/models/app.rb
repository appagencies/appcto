class App
  include Mongoid::Document
  include Mongoid::Slug

  field :name
  field :description
  field :link
  field :platform

  mount_uploader :icon, IconUploader, mount_on: :icon

  embedded_in :company
  embeds_many :screenshots, :cascade_callbacks => true

  attr_accessible :name, :description, :link, :platform, :icon, :icon_cache, :screenshots_attributes
  accepts_nested_attributes_for :screenshots, allow_destroy: true, :reject_if => :all_blank

  slug :name
  validates :name, :presence => true
  validates :description, length: { maximum: 250 }

  class << self
    def cover
      limit(2)
    end
  end

end
