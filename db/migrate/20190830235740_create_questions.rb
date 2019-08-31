class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :task_id
      t.string :user_id
      t.text :title
      t.text :content
      t.boolean :is_open

      t.timestamps
    end
  end
end
