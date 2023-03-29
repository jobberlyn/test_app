# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_29_211139) do
  create_table "paycheck_items", force: :cascade do |t|
    t.integer "paycheck_id", null: false
    t.integer "amount"
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paycheck_id"], name: "index_paycheck_items_on_paycheck_id"
  end

  create_table "paychecks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "date"], name: "index_paychecks_on_user_id_and_date", unique: true
  end

  create_table "rules", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "priority", null: false
    t.string "category", null: false
    t.integer "percentage"
    t.integer "fixed_amount"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "active"], name: "index_rules_on_user_id_and_active"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "date", null: false
    t.integer "amount"
    t.integer "transaction_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "date"], name: "index_transactions_on_user_id_and_date"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

end
