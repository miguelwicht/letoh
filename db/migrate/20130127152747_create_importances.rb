class CreateImportances < ActiveRecord::Migration
  def change
    create_table :importances do |t|
      t.integer :guest_id
      t.integer :interest_id
      t.integer :importance

      t.timestamps
    end
  end
end
