# require 'carrierwave/mongoid'

class App
  include Mongoid::Document
  field :name
  field :description
  field :link

  embedded_in :company

  embeds_one :platform, as: :platformable

  accepts_nested_attributes_for :platform

  validates :name, :presence => true
  validates :description, length: { maximum: 250 }

  class << self
    def cover
      limit(2)
    end
  end

end
