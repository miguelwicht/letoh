class Booking < ActiveRecord::Base
  attr_accessible :from, :room_id, :until
end
