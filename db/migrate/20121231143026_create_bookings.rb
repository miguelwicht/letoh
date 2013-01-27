class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :from
      t.date :until
      t.integer :room_id

      t.timestamps
    end
  end
end
