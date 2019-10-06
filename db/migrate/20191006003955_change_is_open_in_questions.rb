class ChangeIsOpenInQuestions < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :is_open, :boolean, default: true, null: false
  end
end
