class Company
  include Mongoid::Document
  include Mongoid::Slug

  paginates_per 10

  field :name
  field :budget, type: Integer, default: 0
  field :description
  field :platform, type: Array, default: []
  field	:email
  field	:website
  field :user_id
  field :approved, type: Boolean, default: 0

  embeds_one :location, autobuild: true
  embeds_many :apps

  belongs_to :user

  index({ 'location.coordinates' => '2d' },{ background: true, sparse: true })

	mount_uploader :logo, LogoUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :name, :budget, :description, :platform, :email, :website, :logo, :location_attributes
  attr_accessor :size #display size of listing

  slug :name
  validates :name, :presence => true
  validates :name, :length => { :maximum => 100 }, :uniqueness => { :case_sensitive => false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true

  accepts_nested_attributes_for :location, :apps

  #default_scope where(approved: true)

  scope :by_budget,   ->(budget){ where(budget: budget) }
  scope :by_platform, ->(platform){ any_in(platform: platform) }
  scope :by_location, ->(location){ near('location.coordinates' => Geocoder.coordinates(location)) }

  after_initialize do |d|
    if d.apps?
      @size = "large"
    else
      @size = "small"
    end
  end

  def is_approved?
    self.approved == true
  end

  private

  def self.filter(params)
    companies = all
    companies = companies.by_budget(params[:budget]) if params[:budget].present?
    companies = companies.by_platform(params[:platform]) if params[:platform].present?
    companies = companies.by_location(params[:location]) if params[:location].present?
    companies
  end

end