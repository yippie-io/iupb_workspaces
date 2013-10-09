class CreateWorkspaces < ActiveRecord::Migration
  def change
    create_table :workspaces do |t|
      t.string :floor
      t.string :location
      t.text :image_url
      t.integer :qty
      t.references :building

      t.timestamps
    end
  end
end
