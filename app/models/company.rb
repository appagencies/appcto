class Company
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Slug

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

	mount_uploader :logo, LogoUploader, mount_on: :logo

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :name, :budget, :description, :platform, :approved, :email, :website, :logo, :logo_cache, :location_attributes
  attr_accessor :size #display size of listing

  slug :name
  validates :name, :presence => true
  validates :name, :length => { :maximum => 100 }, :uniqueness => { :case_sensitive => false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true
  validates :description, length: { maximum: 500 }

  accepts_nested_attributes_for :location, :apps

  scope :by_budget,   ->(budget){ where(budget: budget) }
  scope :by_platform, ->(platform){ any_in(platform: platform) }
  scope :by_location, ->(location){ near('location.coordinates' => Geocoder.coordinates(location)) }

  after_initialize :set_size

  def set_size
    self.user ||= User.new
    self.user.pro ? @size = 1 : @size = 0
  end

  def is_approved?
    self.approved == true
  end

  def is_new?
    self.created_at >= Time.zone.now - 4.weeks
  end

  private

  def self.filter(params)
    companies = all
    companies = companies.where(approved: true)
    companies = companies.by_budget(params[:budget]) if params[:budget].present?
    companies = companies.by_platform(params[:platform]) if params[:platform].present?
    companies = companies.by_location(params[:location]) if params[:location].present?
    companies
  end

end