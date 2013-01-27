# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Guest.create(:first_name => 'Max', :last_name => 'Mustermann', :birthday => '1989-01-01', :current_city => 'Darmstadt', :tracker_id => 1)
Booking.create(:from => '2013-01-01', :until => '2013-01-10',)