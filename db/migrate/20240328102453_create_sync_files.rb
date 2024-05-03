# frozen_string_literal: true

class CreateSyncFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :sync_files do |t|
      t.bigint :id_order_detail
      t.string :dms_status
      t.string :seasoft_status
      t.string :order_source
      t.string :order_code
      t.string :customer_code
      t.string :customer_name
      t.string :phone_number
      t.string :delivery_address
      t.date :order_date
      t.string :sku_code
      t.string :sku_name
      t.string :unit_of_measure
      t.integer :quantity_sold
      t.string :promotion
      t.decimal :unit_price_minus_vat, precision: 10, scale: 2
      t.decimal :unit_price_plus_vat, precision: 10, scale: 2
      t.decimal :discount_percent_order, precision: 5, scale: 2
      t.decimal :discount_percent_sku, precision: 5, scale: 2
      t.decimal :order_discount, precision: 10, scale: 2
      t.decimal :sku_discount, precision: 10, scale: 2
      t.decimal :total_amount_before_tax, precision: 10, scale: 2
      t.decimal :total_amount_after_discount, precision: 10, scale: 2
      t.decimal :vat_amount, precision: 10, scale: 2
      t.decimal :total_amount_after_vat, precision: 10, scale: 2
      t.decimal :total_amount_before_tax_vat, precision: 10, scale: 2
      t.decimal :total_discount, precision: 10, scale: 2
      t.decimal :total_amount_before_tax_discount, precision: 10, scale: 2
      t.decimal :total_vat_amount, precision: 10, scale: 2
      t.decimal :total_vat_amount_after_vat, precision: 10, scale: 2
      t.integer :order_count
      t.string :region_code
      t.string :region_name
      t.string :area_code
      t.string :area_name
      t.string :distributor_code
      t.string :distributor_name
      t.string :rsm_code
      t.string :rsm_name
      t.string :asm_code
      t.string :asm_name
      t.string :sup_code
      t.string :sup_name
      t.string :sale_code
      t.string :sale_name
      t.string :channel
      t.string :visit
      t.string :brand_code
      t.string :brand_name
      t.timestamps
    end
  end
end
