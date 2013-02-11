class RenamePoisName < ActiveRecord::Migration
  def up
    rename_column :pois, :name, :address
  end

  def down
    rename_column :pois, :address, :name
  end
end
