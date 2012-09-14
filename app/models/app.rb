# require 'carrierwave/mongoid'

class App
  include Mongoid::Document
  field :name
  field :link

  embedded_in :company

  embeds_one :platform, as: :platformable

  accepts_nested_attributes_for :platform

  validates :name, :presence => true

end
