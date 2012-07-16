require 'carrierwave/mongoid'

class Company
  include Mongoid::Document
  include Mongoid::Slug

  field :name
  field :budget, type: Integer
  field :description
  field	:email
  field	:website
  field :skills, type: Array, default: [""]

  embeds_one :location

	mount_uploader :logo, LogoUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  slug :name
  validates :name, :budget, :skills, :presence => true
  validates :name, :length => { :maximum => 100 }, :uniqueness => { :case_sensitive => false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true

  accepts_nested_attributes_for :location

  def self.all_budgets
    CompaniesHelper::BUDGET
  end

end