# require 'carrierwave/mongoid'

class App
  include Mongoid::Document
  field :name
  field :description
  field :link
  field :platform

  embedded_in :company

  attr_accessible :name, :description, :link, :platform

  validates :name, :presence => true
  validates :description, length: { maximum: 250 }

  class << self
    def cover
      limit(2)
    end
  end

end
