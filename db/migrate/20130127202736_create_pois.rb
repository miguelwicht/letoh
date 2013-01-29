class CreatePois < ActiveRecord::Migration
  def change
    create_table :pois do |t|
      t.string :name
      t.decimal :long, :precision => 10, :scale => 6
      t.decimal :lat, :precision => 10, :scale => 6
      t.integer :duration

      t.timestamps
    end
  end
end
