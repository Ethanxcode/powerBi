# frozen_string_literal: true

class SyncFile < ApplicationRecord
  include SyncFilesHelper
  attr_accessor :search_field

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

  def self.import_from_file(uploaded_file)
    # Log để kiểm tra file bắt đầu xử lý
    Rails.logger.info "Bắt đầu xử lý file: #{uploaded_file.path}"

    begin
      spreadsheet = Roo::Spreadsheet.open(uploaded_file.path)
      spreadsheet.sheets.each do |sheet_name|
        sheet = spreadsheet.sheet(sheet_name)
        Rails.logger.info "Đang xử lý sheet: #{sheet_name}"

        # Kiểm tra xem liệu có dữ liệu không
        if sheet.last_row.nil?
          Rails.logger.error "Sheet trống hoặc last_row bằng nil."
          next
        end

        headers = sheet.row(1).map { |header| sync_files_table_headers[header] }.compact
        Rails.logger.info "Headers được xác định: #{headers.join(', ')}"

        (2..sheet.last_row).each do |i|
          row_values = sheet.row(i)[1..-1] # Bỏ qua cột STT đầu tiên
          row_values = row_values[0...headers.length]
          # Đảm bảo rằng khoảng trắng được loại bỏ từ cả tiêu đề và giá trị
          row_values.map! do |cell|
            cell.is_a?(String) ? cell.strip : cell
          end
          # Xác định lại kích thước của row_values dựa trên số cột của headers
          if headers.length != row_values.length
            Rails.logger.error "Kích thước hàng số #{i} không phù hợp: Dự kiến #{headers.length}, nhưng lại nhận được #{row_values.length}"
            next
          end
          row_data = Hash[[headers, row_values].transpose].delete_if { |key, value| key.blank? }

          # Log hàng không có dữ liệu hoặc chỉ có những giá trị nil
          if row_data.values.all?(&:blank?)
            Rails.logger.warn "Hàng số #{i} trống và sẽ bị bỏ qua."
            next
          end

          sync_file = SyncFile.find_or_initialize_by(row_data)
          if sync_file.new_record? || sync_file.changed?
            if sync_file.save
              Rails.logger.info "Đã lưu record: #{row_data.inspect}"
            else
              Rails.logger.error "Lỗi khi lưu record: #{sync_file.errors.full_messages.join(', ')}"
            end
          else
            Rails.logger.info "Không có thay đổi cho record: #{row_data.inspect}"
          end
        end
      end
    rescue => e
      Rails.logger.error "Lỗi khi import file: #{e.message}"
    ensure
      Rails.logger.info "Hoàn thành xử lý file: #{uploaded_file.path}"
    end
  end
end
