class Interest < ActiveRecord::Base
  attr_accessible :name
  has_many :importances
  has_many :guests, :through => :importances
end
