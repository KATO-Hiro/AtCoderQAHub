class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.string :task_id
      t.string :contest_id
      t.string :title

      t.timestamps
    end
  end
end
