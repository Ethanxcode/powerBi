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

ActiveRecord::Schema[7.1].define(version: 2024_05_08_062341) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadatas", primary_key: "key", id: :string, force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "query_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
  end

  create_table "data_center", primary_key: "id_order_detail", id: :bigint, default: nil, force: :cascade do |t|
    t.text "order_status"
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
    t.text "channel"
    t.text "visit"
    t.text "brand_code"
    t.text "brand_name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["id_order_detail"], name: "idx_data_center_lookup"
  end

  create_table "date_centers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dim_customer", primary_key: "customer_id", id: :string, force: :cascade do |t|
    t.serial "surr_id", null: false
    t.string "customer_name"
    t.text "customer_phone"
    t.string "shipping_address"
  end

  create_table "lookup table", id: false, force: :cascade do |t|
    t.float "order_id_detail"
    t.float "stt"
    t.text "stt_dms"
    t.text "stt_seasoft"
    t.text "order_source"
    t.text "order_id"
    t.text "customer_id"
    t.text "customer_name"
    t.text "phone_number"
    t.text "address_delivery"
    t.datetime "order_day", precision: nil
    t.text "product_id"
    t.text "product_name"
    t.text "dvt"
    t.float "quantity"
    t.text "discount"
    t.float "sell_price"
    t.float "sell_price_and_vat"
    t.float "percent_discount_on_order"
    t.float "percent_discount_on_product"
    t.float "discount_order"
    t.float "discount_product"
    t.float "total_amount"
    t.float "total_amount_ck"
    t.float "vat"
    t.float "total_amount_and_vat"
    t.float "total_payment"
    t.float "total_ck"
    t.float "total_payment_ck"
    t.float "total_vat"
    t.float "total_payment_and_vat"
    t.text "region_id"
    t.text "region_name"
    t.text "area_id"
    t.text "area_name"
    t.text "suplier_id"
    t.text "suplier_name"
    t.text "rsm_id"
    t.text "rsm_name"
    t.text "asm_id"
    t.text "asm_name"
    t.text "sup_id"
    t.text "sup_name"
    t.text "sale_id"
    t.text "sale_name"
    t.text "chanel"
    t.text "visit"
    t.text "brand_id"
    t.text "brand_name"
    t.index ["order_id_detail"], name: "idx_lookup table_lookup"
  end

  create_table "product_price", primary_key: "product_code", id: :string, force: :cascade do |t|
    t.integer "stt", null: false
    t.string "product_name"
    t.string "unit_name"
    t.decimal "price"
    t.datetime "effect_from", precision: nil
    t.datetime "effect_to", precision: nil
  end

  create_table "staging", id: false, force: :cascade do |t|
    t.bigint "id_order_detail"
    t.text "order_status"
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
    t.text "channel"
    t.text "visit"
    t.text "brand_code"
    t.text "brand_name"
  end

  create_table "sync_dms", primary_key: "id_order_detail", id: :bigint, default: nil, force: :cascade do |t|
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
    t.text "channel"
    t.text "visit"
    t.text "brand_code"
    t.text "brand_name"
  end

  create_table "sync_files", id: false, force: :cascade do |t|
    t.bigint "id_order_detail"
    t.text "order_status"
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
    t.text "channel"
    t.text "visit"
    t.text "brand_code"
    t.text "brand_name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["id_order_detail"], name: "idx_sync_files_lookup"
  end

  create_table "sync_seasofts", primary_key: "id_order_detail", id: :bigint, default: nil, force: :cascade do |t|
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
    t.text "channel"
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
    t.string "description"
    t.string "status"
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
