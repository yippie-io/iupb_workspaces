class AddLatitudeAndLongitudeToWorkspace < ActiveRecord::Migration
  def change
    add_column :workspaces, :lat, :float
    add_column :workspaces, :lng, :float
  end
end
