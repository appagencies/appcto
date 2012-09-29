class Location
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  geocoded_by :address
  after_validation :geocode

  validates :country, :presence => true

  field :country
  field	:region
  field :city
  field :coordinates, type: Array

  embedded_in :company

  def address
  	"#{city}, #{region}, #{country}"
  end

end
