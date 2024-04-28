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

ActiveRecord::Schema[7.1].define(version: 2024_04_26_041853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadatas", primary_key: "key", id: :string, force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_center", id: false, force: :cascade do |t|
    t.float "no"
    t.float "id_order_detail"
    t.text "dms_status"
    t.text "seasoft_status"
    t.text "order_code"
    t.text "order_source"
    t.text "customer_code"
    t.text "customer_name"
    t.text "customer_phone"
    t.text "shipping_address"
    t.datetime "order_date", precision: nil
    t.text "product_code"
    t.text "product_name"
    t.text "unit_name"
    t.float "quantity"
    t.text "is_promotion"
    t.float "price_before_tax"
    t.float "price"
    t.float "%CK/DH"
    t.float "%CK/SP"
    t.float "ckdh"
    t.float "cksp"
    t.float "tt_tt"
    t.float "tt_chua_vat_da_tru_ck"
    t.float "tien_vat"
    t.float "tt_vat"
    t.float "tong_tt_truoc_vat"
    t.float "tong_ck"
    t.float "tong_tt_chua_vat_da_tru_ck"
    t.float "tong_tien_vat"
    t.float "tong_tt_vat"
    t.text "bill_no"
    t.text "area_code"
    t.text "area_name"
    t.text "region_code"
    t.text "region_name"
    t.text "distributor_code"
    t.text "distributor_name"
    t.text "rsm_code"
    t.text "rsm_name"
    t.text "asm_code"
    t.text "asm_name"
    t.text "sup_code"
    t.text "sup_name"
    t.text "sale_code"
    t.text "sale_name"
    t.text "chanel"
    t.text "visit"
    t.text "brand_code"
    t.text "brand_name"
  end

  create_table "date_centers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sync_dms", primary_key: "no", id: :float, force: :cascade do |t|
    t.float "id_order_detail"
    t.text "dms_status"
    t.text "order_code"
    t.text "customer_code"
    t.text "customer_name"
    t.text "customer_phone"
    t.text "shipping_address"
    t.datetime "order_date", precision: nil
    t.text "product_code"
    t.text "product_name"
    t.text "unit_name"
    t.float "quantity"
    t.text "is_promotion"
    t.float "price_before_tax"
    t.float "price"
    t.float "%CK/DH"
    t.float "%CK/SP"
    t.float "CKDH"
    t.float "CKSP"
    t.float "tt_tt"
    t.float "tt_chua_vat_da_tru_ck"
    t.float "tien_vat"
    t.float "tt_vat"
    t.float "tong_tt_truoc_vat"
    t.float "tong_ck"
    t.float "tong_tt_chua_vat_da_tru_ck"
    t.float "tong_tien_vat"
    t.float "tong_tt_vat"
    t.text "bill_no"
    t.text "area_code"
    t.text "area_name"
    t.text "region_code"
    t.text "region_name"
    t.text "distributor_code"
    t.text "distributor_name"
    t.text "rsm_code"
    t.text "rsm_name"
    t.text "asm_code"
    t.text "asm_name"
    t.text "sup_code"
    t.text "sup_name"
    t.text "sale_code"
    t.text "sale_name"
    t.text "chanel"
    t.text "visit"
    t.text "brand_code"
    t.text "brand_name"
  end

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

  create_table "sync_seasofts", id: false, force: :cascade do |t|
    t.float "id_order_detail"
    t.float "no"
    t.text "seasoft_status"
    t.text "order_code"
    t.text "customer_code"
    t.text "customer_name"
    t.text "customer_phone"
    t.text "shipping_address"
    t.datetime "order_date", precision: nil
    t.text "product_code"
    t.text "product_name"
    t.text "unit_name"
    t.float "quantity"
    t.text "is_promotion"
    t.float "price_before_tax"
    t.float "price"
    t.float "%CK/DH"
    t.float "%CK/SP"
    t.float "ckdh"
    t.float "cksp"
    t.float "tt_tt"
    t.float "tt_chua_vat_da_tru_ck"
    t.float "tien_vat"
    t.float "tt_vat"
    t.float "tong_tt_truoc_vat"
    t.float "tong_ck"
    t.float "tong_tt_chua_vat_da_tru_ck"
    t.float "tong_tien_vat"
    t.float "tong_tt_vat"
    t.text "bill_no"
    t.text "area_code"
    t.text "area_name"
    t.text "region_code"
    t.text "region_name"
    t.text "distributor_code"
    t.text "distributor_name"
    t.text "rsm_code"
    t.text "rsm_name"
    t.text "asm_code"
    t.text "asm_name"
    t.text "sup_code"
    t.text "sup_name"
    t.text "sale_code"
    t.text "sale_name"
    t.text "chanel"
    t.text "visit"
    t.text "brand_code"
    t.text "brand_name"
    t.index ["id_order_detail"], name: "idx_data_seasoft_lookup"
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
