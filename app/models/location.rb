class Location
  include Mongoid::Document

  validates :country, :presence => true

  field :country
  field	:region

  embedded_in :company

end
