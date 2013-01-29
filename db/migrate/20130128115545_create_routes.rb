class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :route
      t.boolean :active

      t.timestamps
    end
  end
end
