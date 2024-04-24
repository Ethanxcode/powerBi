# frozen_string_literal: true
# rubocop:disable all
# app/models/user.rb
class SyncDmss < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[
      order_detail_id
      dms_status
      seasoft_status
      order_source
      order_code
      customer_code
      customer_name
      phone_number
      delivery_address
      order_date
      sku_code
      sku_name
      unit_of_measure
      quantity_sold
      promotion
      unit_price_minus_vat
      unit_price_plus_vat
      discount_percent_order
      discount_percent_sku
      order_discount
      sku_discount
      total_amount_before_tax
      total_amount_after_discount
      vat_amount
      total_amount_after_vat
      total_amount_before_tax_vat
      total_discount
      total_amount_before_tax_discount
      total_vat_amount
      total_amount_after_vat
      order_count
      region_code
      region_name
      area_code
      area_name
      distributor_code
      distributor_name
      rsm_code
      rsm_name
      asm_code
      asm_name
      sup_code
      sup_name
      sale_code
      sale_name
      channel
      visit
      brand_code
      brand_name
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  # Clear the connection cache
  Dms.connection.clear_cache!

  def self.insert_from_api(agrs)
    errors = []

    Dms.transaction do
      agrs["data"].each do |user_data|
        begin
          # Tạo một hash để lưu trữ các trường có giá trị để cập nhật hoặc tạo người dùng
          attributes_to_update = {}

          user_data.each do |key, value|
            if value.present? && User.column_names.include?(key)
              attributes_to_update[key] = value
            end
          end

          next if attributes_to_update.empty?

          user = User.find_or_initialize_by(id: user_data['id'])

          user.attributes = attributes_to_update
          if user.save!
            Rails.logger.info "User updated successfully with ID: #{user_data['id']}"
          else
            Rails.logger.error "Failed to update user: #{user.errors.full_messages.join(", ")}"
            errors << { id: user.id, errors: user.errors.full_messages }
          end
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error "Failed to update records: #{e.message}"
          errors << { id: user&.id, errors: [e.message] }
        end
      end
    end

    errors
  end
end
