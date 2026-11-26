class ReplaceCompletedWithStatus < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :status, :string, default: "Pending", null: false

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE tasks
          SET status = CASE
            WHEN completed = TRUE THEN 'Completed'
            ELSE 'Pending'
          END
        SQL
      end
    end

    remove_column :tasks, :completed, :boolean
  end
end
