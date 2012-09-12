class Platform
  include Mongoid::Document

  field :name

  embedded_in :platformable, polymorphic: true

end
