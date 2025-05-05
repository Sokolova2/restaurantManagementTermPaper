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

ActiveRecord::Schema[8.0].define(version: 2025_04_12_150917) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chip_basket_items", force: :cascade do |t|
    t.bigint "chip_basket_id"
    t.bigint "dish_and_drink_id", null: false
    t.integer "number_of_dish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chip_basket_id"], name: "index_chip_basket_items_on_chip_basket_id"
    t.index ["dish_and_drink_id"], name: "index_chip_basket_items_on_dish_and_drink_id"
  end

  create_table "chip_baskets", force: :cascade do |t|
    t.bigint "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_chip_baskets_on_table_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "phone_number"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dish_and_drinks", force: :cascade do |t|
    t.string "name"
    t.float "grams"
    t.string "category"
    t.string "category_type"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "password"
    t.string "last_name"
    t.string "first_name"
    t.string "parent_name"
    t.string "job_title"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees_orders", id: false, force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "order_id", null: false
    t.index ["employee_id"], name: "index_employees_orders_on_employee_id"
    t.index ["order_id"], name: "index_employees_orders_on_order_id"
  end

  create_table "feedback_and_suggestions", force: :cascade do |t|
    t.string "feedback"
    t.string "phone_number"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_feedback_and_suggestions_on_client_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "dish_and_drink_id", null: false
    t.string "name"
    t.float "grams"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_and_drink_id"], name: "index_ingredients_on_dish_and_drink_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "dish_and_drink_id", null: false
    t.bigint "order_id", null: false
    t.integer "number_of_dishes"
    t.string "dish_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_and_drink_id"], name: "index_order_items_on_dish_and_drink_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "order_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "table_id", null: false
    t.index ["employee_id"], name: "index_orders_on_employee_id"
    t.index ["table_id"], name: "index_orders_on_table_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "table_number"
    t.string "link_for_web"
    t.bigint "employee_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_tables_on_client_id"
    t.index ["employee_id"], name: "index_tables_on_employee_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chip_basket_items", "chip_baskets"
  add_foreign_key "chip_basket_items", "dish_and_drinks"
  add_foreign_key "chip_baskets", "tables"
  add_foreign_key "feedback_and_suggestions", "clients"
  add_foreign_key "ingredients", "dish_and_drinks"
  add_foreign_key "order_items", "dish_and_drinks"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "employees"
  add_foreign_key "orders", "tables"
  add_foreign_key "tables", "clients"
  add_foreign_key "tables", "employees"
end
