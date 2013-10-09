class CreateEquipmentsWorkspaces < ActiveRecord::Migration
  def change
    create_table :equipment_workspaces, id: false do |t|
      t.references :equipment
      t.references :workspace
    end
  end
end
