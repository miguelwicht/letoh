class Guest < ActiveRecord::Base
  attr_accessible :birthday, :current_city, :first_name, :last_name, :tracker_id
end
