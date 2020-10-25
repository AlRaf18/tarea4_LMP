class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :description
      t.string :title
      t.string :attendant

      t.timestamps
    end
  end
end
