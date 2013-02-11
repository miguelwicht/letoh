class AddDescriptionToPois < ActiveRecord::Migration
  def change
    add_column :pois, :description, :string
  end
end
