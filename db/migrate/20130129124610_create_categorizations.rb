class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :poi_id
      t.integer :interest_id

      t.timestamps
    end
  end
end
