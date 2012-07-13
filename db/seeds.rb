require 'open-uri'
require 'json'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#puts 'Setting up default user login'
#user = User.create! :email => "user@admin.com", :password => 'please'
#puts 'New user created: ' << user.email

# Countries
Country.delete_all
countries = JSON.parse(open("https://raw.github.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/slim-2/slim-2.json").read)
countries.each do |country|
	Country.create!(:name => country["name"], :code => country["alpha-2"])
end
puts 'Countries imported succesfully'