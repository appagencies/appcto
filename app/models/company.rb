require 'carrierwave/mongoid'

class Company
  include Mongoid::Document
  include Mongoid::Slug

  field :name
  field :budget, type: Integer, default: 0
  field :description
  field	:email
  field	:website
  field :skills, type: Array, default: [""]
  field :user_id

  embeds_one :location
  belongs_to :user

	mount_uploader :logo, LogoUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  slug :name
  validates :name, :presence => true
  validates :name, :length => { :maximum => 100 }, :uniqueness => { :case_sensitive => false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true

  accepts_nested_attributes_for :location

  def self.all_budgets
    CompaniesHelper::BUDGET
  end

end