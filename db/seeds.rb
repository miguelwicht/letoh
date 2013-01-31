#ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create some guests
Guest.create(:first_name => 'Max', :last_name => 'Mustermann', :birthday => '1989-01-01', :current_city => 'Darmstadt', :tracker_id => 1)
Guest.create(:first_name => 'Maria', :last_name => 'Mustermann', :birthday => '1988-06-01', :current_city => 'Darmstadt', :tracker_id => 2)
Guest.create(:first_name => 'Hans', :last_name => 'Mueller', :birthday => '1983-11-01', :current_city => 'Frankfurt am Main', :tracker_id => 3)

# create some interests
Interest.create(:name => 'Streetart')
Interest.create(:name => 'Modern')
Interest.create(:name => 'Klassisch')
Interest.create(:name => 'Schiffe')
Interest.create(:name => 'Parks')
Interest.create(:name => 'See')

#create some importances
Importance.create(:guest_id => 1, :interest_id => 1, :importance => 50) #Streetart
Importance.create(:guest_id => 1, :interest_id => 2, :importance => 50) #Modern
Importance.create(:guest_id => 2, :interest_id => 3, :importance => 50) #Klassisch
Importance.create(:guest_id => 2, :interest_id => 4, :importance => 50) #Schiffe
Importance.create(:guest_id => 3, :interest_id => 5, :importance => 50) #Parks
Importance.create(:guest_id => 3, :interest_id => 6, :importance => 50) #See


#create some categorizations
#Streetart
Categorization.create(:poi_id => 1, :interest_id => 1)
Categorization.create(:poi_id => 2, :interest_id => 1)
Categorization.create(:poi_id => 3, :interest_id => 1)
#Modern
Categorization.create(:poi_id => 4, :interest_id => 2)
Categorization.create(:poi_id => 5, :interest_id => 2)
Categorization.create(:poi_id => 6, :interest_id => 2)
#Klassisch
Categorization.create(:poi_id => 7, :interest_id => 3)
Categorization.create(:poi_id => 8, :interest_id => 3)
Categorization.create(:poi_id => 9, :interest_id => 3)
#Schiffe
Categorization.create(:poi_id => 10, :interest_id => 4)
Categorization.create(:poi_id => 11, :interest_id => 4)
Categorization.create(:poi_id => 12, :interest_id => 4)
#Parks

#See

#Booking.create(:from => '2013-01-01', :until => '2013-01-10')

# Streetart
Poi.create(:long => '13.42204', :lat => '52.49819', :name => 'Mariannenstraße, 10999 Berlin', :duration => '5')
Poi.create(:long => '13.4401444', :lat => '52.4988915', :name => 'Oppelner Straße, 10997 Berlin', :duration => '10')
Poi.create(:long => '13.44566', :lat => '52.50051', :name => 'Cuvrystraße 2, 10997 Berlin', :duration => '8')
Poi.create(:long => '13.3989857', :lat => '52.5255793', :name => 'Große Hamburger Straße, 10119 Berlin', :duration => '15')
Poi.create(:long => '13.4050361', :lat => '52.5256091', :name => 'Weinmeisterstraße, 10178 Berlin', :duration => '7')

# Parks
Poi.create(:long => '13.357388', :lat => '52.513818', :name => 'Großer Tiergarten', :duration => '30')
Poi.create(:long => '13.417136', :lat => '52.483251', :name => 'Volkspark Hasenheide', :duration => '30')
Poi.create(:long => '13.469011', :lat => '52.488752', :name => 'Treptower Park', :duration => '30')

# See
Poi.create(:long => '13.650659', :lat => '52.432153', :name => 'Müggelspree-Müggelsee', :duration => '30')
Poi.create(:long => '13.734666', :lat => '52.421685', :name => 'Dämeritzsee', :duration => '30')
Poi.create(:long => '13.803972', :lat => '52.419278', :name => 'Werlsee', :duration => '30')

