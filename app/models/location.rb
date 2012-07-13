class Location
  include Mongoid::Document

  field :city
  field	:region
  field :coordinates, type: Array

  belongs_to :country

  embedded_in :company

end
