class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :url
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
