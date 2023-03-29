class CreatePaycheckItem < ActiveRecord::Migration[7.0]
  def change
    create_table :paycheck_items do |t|
      t.integer :paycheck_id, null: false
      t.integer :amount
      t.string :category, null: false

      t.timestamps

      t.index :paycheck_id
    end
  end
end
