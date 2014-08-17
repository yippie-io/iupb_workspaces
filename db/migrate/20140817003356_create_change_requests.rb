class CreateChangeRequests < ActiveRecord::Migration
  def change
    create_table :change_requests do |t|
      t.text :feedback
      t.float :lat
      t.float :lng
      t.string :workspace_name
      t.integer :workspace_id
      t.string :kind

      t.timestamps
    end
  end
end
