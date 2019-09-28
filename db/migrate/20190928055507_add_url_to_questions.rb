class AddUrlToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :url, :text
  end
end
