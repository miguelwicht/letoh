class Poi < ActiveRecord::Base
  attr_accessible :duration, :lat, :long, :address, :description, :name
  has_many :categorizations
  has_many :interests, :through => :categorizations
end
