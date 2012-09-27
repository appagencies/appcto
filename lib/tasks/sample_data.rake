require "#{Rails.root}/app/helpers/companies_helper"
include CompaniesHelper

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reseed'].invoke
    make_users
    make_companies
    make_locations
  end
end

def make_users
  puts "Creating users..."
  99.times do |n|
    email = Faker::Internet.email
    password = "password"
    User.create!(:email => email,
                 :password => password)
  end
end

def make_companies
  puts "Creating user companies..."
  User.all.each do |user|
    name = Faker::Company.name
    description = Faker::Lorem.paragraph(5)
    budget = rand(0..3)
    all_platforms = PLATFORMS
    platform = all_platforms.sample(rand(1..all_platforms.count))
    website = 'http://' + Faker::Internet.domain_name
    user.create_company(:name => name,
                        :description => description,
                        :budget => budget,
                        :email => user.email,
                        :platform => platform,
                        :website => website,
                        :approved => true)
  end
end

def make_locations
  puts "Creating company locations..."
  Company.all.each do |company|
    country = "US"
    region = Faker::Address.state_abbr
    company.create_location(:country => country,
                            :region => region)
  end
end