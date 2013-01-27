class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :last_name
      t.string :first_name
      t.date :birthday
      t.string :current_city
      t.integer :tracker_id

      t.timestamps
    end
  end
end
