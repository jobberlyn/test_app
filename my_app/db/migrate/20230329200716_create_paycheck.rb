class CreatePaycheck < ActiveRecord::Migration[7.0]
  def change
    create_table :paychecks do |t|
      t.integer :user_id, null: false
      t.date :date, null: false

      t.timestamps

      t.index [:user_id, :date], unique: true
    end
  end
end
