class CreateTransaction < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id, null: false
      t.date :date, null: false
      t.integer :amount
      t.integer :type, null: false 

      t.timestamps

      t.index [:user_id, :date]
    end
  end
end
