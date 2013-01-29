class Poi < ActiveRecord::Base
  attr_accessible :duration, :lat, :long, :name
  has_many :categorizations
  has_many :interests, :through => :categorizations
end
