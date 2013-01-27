class Guest < ActiveRecord::Base
  attr_accessible :birthday, :current_city, :first_name, :last_name, :tracker_id
  has_many :importances
  has_many :interests, :through => :importances
end
