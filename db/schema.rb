# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 2024_03_29_015654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sync_files", force: :cascade do |t|
    t.bigint "order_detail_id"
    t.string "dms_status"
    t.string "seasoft_status"
    t.string "order_source"
    t.string "order_code"
    t.string "customer_code"
    t.string "customer_name"
    t.string "phone_number"
    t.string "delivery_address"
    t.date "order_date"
    t.string "sku_code"
    t.string "sku_name"
    t.string "unit_of_measure"
    t.integer "quantity_sold"
    t.string "promotion"
    t.decimal "unit_price_minus_vat", precision: 10, scale: 2
    t.decimal "unit_price_plus_vat", precision: 10, scale: 2
    t.decimal "discount_percent_order", precision: 10, scale: 2
    t.decimal "discount_percent_sku", precision: 10, scale: 2
    t.decimal "order_discount", precision: 10, scale: 2
    t.decimal "sku_discount", precision: 10, scale: 2
    t.decimal "total_amount_before_tax", precision: 10, scale: 2
    t.decimal "total_amount_after_discount", precision: 10, scale: 2
    t.decimal "vat_amount", precision: 10, scale: 2
    t.decimal "total_amount_after_vat", precision: 10, scale: 2
    t.decimal "total_amount_before_tax_vat", precision: 10, scale: 2
    t.decimal "total_discount", precision: 10, scale: 2
    t.decimal "total_amount_before_tax_discount", precision: 10, scale: 2
    t.decimal "total_vat_amount", precision: 10, scale: 2
    t.decimal "total_vat_amount_after_vat", precision: 10, scale: 2
    t.integer "order_count"
    t.string "region_code"
    t.string "region_name"
    t.string "area_code"
    t.string "area_name"
    t.string "distributor_code"
    t.string "distributor_name"
    t.string "rsm_code"
    t.string "rsm_name"
    t.string "asm_code"
    t.string "asm_name"
    t.string "sup_code"
    t.string "sup_name"
    t.string "sale_code"
    t.string "sale_name"
    t.string "channel"
    t.string "visit"
    t.string "brand_code"
    t.string "brand_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sync_times_records", force: :cascade do |t|
    t.string "record_name"
    t.datetime "last_sync_time"
    t.string "sync_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :bigint, default: nil, force: :cascade do |t|
    t.string "account", null: false
    t.integer "phone_number"
    t.string "email"
    t.string "full_name"
    t.string "permission"
    t.boolean "status"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
  end

end
