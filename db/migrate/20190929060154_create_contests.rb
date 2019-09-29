class CreateContests < ActiveRecord::Migration[5.2]
  def change
    create_table :contests do |t|
      t.string :contest_id
      t.bigint :start_epoch_second
      t.string :title

      t.timestamps
    end
  end
end
