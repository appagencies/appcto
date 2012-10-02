class Location
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  geocoded_by :name
  after_validation :geocode, :if => lambda{ |obj| obj.name_changed? }

  field :name
  field :coordinates, type: Array

  embedded_in :company

end
