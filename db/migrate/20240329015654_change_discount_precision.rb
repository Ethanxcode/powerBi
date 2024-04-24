# frozen_string_literal: true

class ChangeDiscountPrecision < ActiveRecord::Migration[7.1]
  def change
    change_column :sync_files, :discount_percent_order, :decimal, precision: 10, scale: 2
    change_column :sync_files, :discount_percent_sku, :decimal, precision: 10, scale: 2
  end
end
