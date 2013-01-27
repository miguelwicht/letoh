class Importance < ActiveRecord::Base
  attr_accessible :guest_id, :importance, :interest_id
  belongs_to :guest
  belongs_to :interest
end
