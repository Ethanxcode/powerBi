# frozen_string_literal: true

class AddNewFieldsToSyncFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :sync_files, :units, :string
    add_column :sync_files, :area, :string
    add_column :sync_files, :region, :string
    add_column :sync_files, :system, :string
    add_column :sync_files, :channel, :string
    add_column :sync_files, :supplier, :string
    add_column :sync_files, :price_by_price_list, :decimal, precision: 15, scale: 2
    add_column :sync_files, :rev_by_price_list, :decimal, precision: 15, scale: 2
    add_column :sync_files, :pct_promo_and_trade, :decimal, precision: 5, scale: 2
    add_column :sync_files, :promo_and_trade, :decimal, precision: 15, scale: 2
    add_column :sync_files, :types, :string
    add_column :sync_files, :pct_trade_team_pay_later, :decimal, precision: 5, scale: 2
    add_column :sync_files, :trade_team_pay_later, :decimal, precision: 15, scale: 2
    add_column :sync_files, :margin_trade, :decimal, precision: 15, scale: 2
    add_column :sync_files, :pct_margin_trade, :decimal, precision: 5, scale: 2
    add_column :sync_files, :promo_prod_by_sale_price, :string
    add_column :sync_files, :pct_promo_prod_by_sale_price_rev, :decimal, precision: 5, scale: 2
    add_column :sync_files, :pct_trade_team_issuing_invoice, :decimal, precision: 5, scale: 2
    add_column :sync_files, :trade_team_issuing_invoice, :string
    add_column :sync_files, :pct_promo_prog_disc, :decimal, precision: 5, scale: 2
    add_column :sync_files, :promo_prog_disc, :decimal, precision: 15, scale: 2
    add_column :sync_files, :sale, :string
    add_column :sync_files, :supervisor, :string
    add_column :sync_files, :asm, :string
    add_column :sync_files, :salary_sale, :decimal, precision: 15, scale: 2
    add_column :sync_files, :salary_supervisor, :decimal, precision: 15, scale: 2
    add_column :sync_files, :salary_asm, :decimal, precision: 15, scale: 2
    add_column :sync_files, :ttl_sale_volume, :decimal, precision: 15, scale: 2
    add_column :sync_files, :pct_sale_volume_rev, :decimal, precision: 5, scale: 2
    add_column :sync_files, :margin_ttl_sale, :decimal, precision: 15, scale: 2
    add_column :sync_files, :pct_margin_ttl_sale, :decimal, precision: 5, scale: 2
    add_column :sync_files, :warehouse_for_export, :string
    add_column :sync_files, :delivery_cost, :decimal, precision: 15, scale: 2
    add_column :sync_files, :warehouse_and_management_cost, :decimal, precision: 15, scale: 2
    add_column :sync_files, :ttl_logistics_cost, :decimal, precision: 15, scale: 2
    add_column :sync_files, :pct_logistics_cost_rev, :decimal, precision: 5, scale: 2
    add_column :sync_files, :margin_logistics_cost, :decimal, precision: 15, scale: 2
    add_column :sync_files, :pct_margin_logistics_cost, :decimal, precision: 5, scale: 2
    add_column :sync_files, :sku_purchased, :integer
    add_column :sync_files, :ttl_units_purchased, :integer
    add_column :sync_files, :num_orders, :integer
    add_column :sync_files, :rev, :decimal, precision: 15, scale: 2
    add_column :sync_files, :cost_price, :decimal, precision: 15, scale: 2
    add_column :sync_files, :trade_terms, :string
    add_column :sync_files, :disc, :decimal, precision: 15, scale: 2
    add_column :sync_files, :promo_prod_cost_price, :decimal, precision: 15, scale: 2
    add_column :sync_files, :promo_prod_sale_price, :decimal, precision: 15, scale: 2
    add_column :sync_files, :sales_salary, :decimal, precision: 15, scale: 2
    add_column :sync_files, :logistic_cost, :decimal, precision: 15, scale: 2
    add_column :sync_files, :num_sales_30_11_2023, :integer
    add_column :sync_files, :num_sales_buy_prod_per_month, :integer
    add_column :sync_files, :order_plac_rate_month, :decimal, precision: 15, scale: 2
    add_column :sync_files, :num_skus_2023, :decimal, precision: 15, scale: 2
    add_column :sync_files, :val_orders_bq_2023, :decimal, precision: 15, scale: 2
    add_column :sync_files, :num_sales_not_buy_prod, :integer
  end
end
