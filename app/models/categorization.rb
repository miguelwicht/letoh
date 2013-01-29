class Categorization < ActiveRecord::Base
  attr_accessible :interest_id, :poi_id
  belongs_to :interest
  belongs_to :poi
end
