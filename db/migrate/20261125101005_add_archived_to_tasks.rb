class AddArchivedToTasks < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :archived, :boolean, default: false, null: false
  end
end
