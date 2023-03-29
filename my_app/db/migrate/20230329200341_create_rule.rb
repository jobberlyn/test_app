class CreateRule < ActiveRecord::Migration[7.0]
  def change
    create_table :rules do |t|
      t.integer :user_id, null: false
      t.integer :priority, null: false
      t.string :category, null: false
      t.integer :percentage
      t.integer :fixed_amount
      t.boolean :active, default: true

      t.timestamps

      t.index [:user_id, :active]
    end
  end
end
