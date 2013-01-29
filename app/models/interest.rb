class Interest < ActiveRecord::Base
  attr_accessible :name
  has_many :importances
  has_many :guests, :through => :importances
  has_many :categorizations
  has_many :pois, :through => :categorizations
end
