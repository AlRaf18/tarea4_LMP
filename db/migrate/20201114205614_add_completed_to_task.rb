class AddCompletedToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completed, :bool
  end
end
