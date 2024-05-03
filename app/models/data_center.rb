# frozen_string_literal: true

class DataCenter < ApplicationRecord
  include DataCenterHelper
  attr_accessor :search_field
  self.table_name = "data_center"

  UNRANSACKABLE_ATTRIBUTES = [
    'quantity',
    'is_promotion',
    'price_before_tax',
    'price',
    '%CK/DH',
    '%CK/SP',
    'ckdh',
    'cksp',
    'tt_tt',
    'tt_chua_vat_da_tru_ck',
    'tien_vat',
    'tt_vat',
    'tong_tt_truoc_vat',
    'tong_ck',
    'tong_tt_chua_vat_da_tru_ck',
    'tong_tien_vat',
    'tong_tt_vat',
  ]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    []
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

  def self.auto_insert_from_api(api_url)
    query_string = 'code=DTP-HCM-2403000164&customer_name=&customer_code=&customer_phone=&partner_name=&status=&order_channel=&payment_status=&distributor_id=&distributor_code=&distributor_name=&from=&to=&order_type=&customer_group_code=&city_code=&city_name=&district_code=&district_name=&ward_code=&ward_name=&shipping_method_code=&customer_group_name=&product_code=&product_name=&payment_method=&qr_scan=&outvat=&transfer_confirmation=&payment_code=&lading_method=&shipping_note=&is_seller=&status_crm=&weight_form=&weight_to=&seller_full_name=&seller_id=&leader_id=&leader_full_name=&order_source=&saleman_code=&saleman_name=&area_code=&warehouse_name=&warehouse_code=&status_seasoft=&channel=&bill_no=&is_seasoft=&only_saleman=&chain_id=&all_order_child=1&po_number=&like_code=&time=12%3A00%3A35&limit=40&sort%5C[created_at%5C]=desc&is_data_en=1'
  
    params = CGI.parse(query_string)
  
    importer = DataImporter.new(api_url, params)
    response = importer.import_data
    ip_address = request.remote_ip
  
    if response
      begin
        puts "Data retrieval successful. Inserting data from API..."
        DataCenter.insert_from_api(response)
        Rails.logger.info "Data insertion complete."
        SyncTimesRecord.update_sync_time('data_center', "SYSTEM")
        return
      rescue StandardError => e
        puts "Error updating last sync time for table data_center #{e.message}"
      end
    else
      puts "Failed to retrieve data from the host API."
      return
    end
  rescue => e
    puts "An error occurred: #{e.message}"
    puts "Rolling back transaction..."
    head :unprocessable_entity
  end
  
end
