# frozen_string_literal: true

class DataCenter < ApplicationRecord
  include DataCenterHelper
  attr_accessor :search_field

  def self.ransackable_attributes(auth_object = nil)
    %w[
      no
      id_order_detail
      dms_status
      seasoft_status
      order_code
      order_source
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

  def self.insert_from_api(result)
    puts result
    errors = []

    if result.is_a?(Hash) && result["data"].is_a?(Array)
      Rails.logger.info "Starting transaction for data import"
      ActiveRecord::Base.transaction do
        result["data"].each do |data|
          begin
            if data["order_source"] == DMS
              # For SyncDms model
              Rails.logger.info "Processing data for SyncDms model with id: #{data["id_order_detail"]}"
              sync_dms = SyncDms.find_or_initialize_by(id_order_detail: data["id_order_detail"])
              sync_dms.attributes = data.except("no", "order_source", "seasoft_status")
              sync_dms.save!
              Rails.logger.info "Successfully saved SyncDms record with id: #{data["id_order_detail"]}"
              SyncTimesRecord.update_sync_time("sync_dms")

            else
              # For SyncSeasoft model
              Rails.logger.info "Processing data for SyncSeasoft model with id: #{data["id_order_detail"]}"
              sync_seasoft = SyncSeasoft.find_or_initialize_by(id_order_detail: data["id_order_detail"])
              sync_seasoft.attributes = data.except("no", "dms_status", "order_source")
              sync_seasoft.save!
              Rails.logger.info "Successfully saved SyncSeasoft record with id: #{data["id_order_detail"]}"
              SyncTimesRecord.update_sync_time("sync_seasoft", "order_source")
            end
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error "Failed to update record with id #{data["id_order_detail"]}: #{e.message}"
            errors << { id_order_detail: data["id_order_detail"], errors: [e.message] }
          end
        end
      end
      Rails.logger.info "Finished transaction for data import"
    else
      Rails.logger.warn "Result is not a hash or does not contain an array of data"
    end

    errors.each do |error|
      Rails.logger.error "Failed to update record with id #{error[:id]}: #{error[:errors].join(', ')}"
    end

    errors
  end
end
