# frozen_string_literal: true
# rubocop:disable all

class SyncDms < ApplicationRecord
  include SyncDmsHelper
  attr_accessor :search_field

  def self.ransackable_attributes(auth_object = nil)
    %w[
      no
      id_order_detail
      dms_status
      order_code
      customer_code
      customer_name
      customer_phone
      shipping_address
      order_date
      product_code
      product_name
      unit_name
      quantity
      is_promotion
      price_before_tax
      price
      p_ck/sp
      p_ck/dh
      ckdh
      cksp
      tt_tt
      tt_chua_vat_da_tru_ck
      tien_vat
      tt_vat
      tong_tt_truoc_vat
      tong_ck
      tong_tt_chua_vat_da_tru_ck
      tong_tien_vat
      tong_tt_vat
      bill_no
      area_code
      area_name
      region_code
      region_name
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
  SyncDms.connection.clear_cache!

  def self.insert_from_api(agrs)
    errors = []

    SyncDms.transaction do
      agrs["data"].each do |data|
        begin
          # Tạo một hash để lưu trữ các trường có giá trị để cập nhật hoặc tạo người dùng
          attributes_to_update = {}

          data.each do |key, value|
            if value.present? && User.column_names.include?(key)
              attributes_to_update[key] = value
            end
          end

          next if attributes_to_update.empty?

          data = SyncDms.find_or_initialize_by(id: data['id'])

          data.attributes = attributes_to_update
          if data.save!
            Rails.logger.info "User updated successfully with ID: #{data['id']}"
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
