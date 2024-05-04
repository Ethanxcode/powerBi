# frozen_string_literal: true

require "faraday"
require "json"
require "uri"

class DataImporter
  def initialize(root_path = nil, params = {})
    encoded_params = URI.encode_www_form(params)
    @path = params.empty? ? root_path : "#{root_path}?#{encoded_params}"
  end

  def import_from_file(uploaded_file)
    Rails.logger.info "Bắt đầu xử lý file: #{uploaded_file.path}"
    errors = []

    workbook = Axlsx::Package.new
    workbook.use_shared_strings = true

    begin
      spreadsheet = Roo::Spreadsheet.open(uploaded_file.path)
      spreadsheet.sheets.each do |sheet_name|
        sheet = spreadsheet.sheet(sheet_name)
        Rails.logger.info "Đang xử lý sheet: #{sheet_name}"

        next if sheet.last_row.nil?

        headers = determine_headers(sheet)
        worksheet = create_worksheet(workbook, sheet_name, headers)

        errors = process_rows(sheet, headers, worksheet, errors)
      end
    rescue => e
      Rails.logger.error "Lỗi khi import file: #{e.message}"
    ensure
      Rails.logger.info "Hoàn thành xử lý file: #{uploaded_file.path}"
      return generate_error_file(workbook, uploaded_file)
    end
  end

  def import_data
    response = fetch_data_from_api
    if response&.success?
      parse_api_response(response.body)
    else
      Rails.logger.error("Failed to fetch data from API: #{response&.status}")
      nil
    end
  end

  private

    def fetch_data_from_api
      conn = Faraday.new(url: @path)
      begin
        response = conn.get(@path) do |req|
          req.headers["Accept"] = "application/json, text/plain, */*"
          req.headers["Accept-Language"] = "vi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5"
          req.headers["Cache-Control"] = "no-cache"
          req.headers["Connection"] = "keep-alive"
          req.headers["x-api-key"] = "88"
        end

        return response if response.success?

        Rails.logger.error("Request failed with status code #{response&.status}")
        puts "Request failed with status code #{response&.status}"
        error = Errors::ErrorsHandler.send(:error_class, response&.status, response)
        puts error
        raise error
      rescue Faraday::ConnectionFailed => e
        Rails.logger.error("Connection failed: #{e.message}")
        nil
      end
    end

    def parse_api_response(response_body)
      parsed_response = JSON.parse(response_body)
      parsed_response = { "data" => parsed_response } if parsed_response.is_a?(Array)
      parsed_response
    rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse API response: #{e.message}")
      puts "Failed to parse API response: #{e.message}"
      error_data = Errors::ErrorsHandler.handle_record_invalid(e, response_body)
      puts error_data
      raise error_data
    end

    def determine_headers(sheet)
      headers = sheet.row(1).map { |header| SyncFilesHelper.sync_files_attributes[header] }.compact
      Rails.logger.info "Headers được xác định: #{headers.join(', ')}"
      headers
    end

    def create_worksheet(workbook, sheet_name, headers)
      worksheet = workbook.workbook.add_worksheet(name: sheet_name)
      worksheet.add_row headers
      worksheet
    end

    def process_rows(sheet, headers, worksheet, errors)
      (2..sheet.last_row).each do |i|
        row_values = sheet.row(i)[0..-1]
        row_values = row_values[0...headers.length]
        row_values.map! { |cell| cell.is_a?(String) ? cell.strip : cell }

        next if headers.length != row_values.length

        row_data = Hash[[headers, row_values].transpose].delete_if { |key, value| key.blank? }

        next if row_data.values.all?(&:blank?)

        handle_order_date(row_data)

        sync_file = SyncFile.find_or_initialize_by(row_data)
        errors << handle_sync_file_errors(sync_file)
        add_row_to_worksheet(worksheet, row_values)
      end

      handle_errors_in_worksheet(worksheet, errors) if errors.any?
      errors
    end

    def handle_order_date(row_data)
      if row_data[:order_date].present?
        row_data[:order_date] = Time.zone.at(row_data[:order_date]).to_datetime if row_data[:order_date].is_a?(Integer)
        row_data[:order_date] = row_data[:order_date].to_s
      end
    end

    def handle_sync_file_errors(sync_file)
      sync_file.save ? nil : "Lỗi khi lưu record: #{sync_file.errors.full_messages.join(', ')}"
    end

    def add_row_to_worksheet(worksheet, row_values)
      worksheet.add_row row_values.map(&:to_s)
    end

    def handle_errors_in_worksheet(worksheet, errors)
      Rails.logger.debug "Worksheet rows: #{worksheet.rows.size}"
      worksheet.rows.each_with_index do |row, index|
        next if index == 0

        row.add_cell(errors[index - 1] || "")
      end
    end

    def generate_error_worksheet(workbook, errors, uploaded_file)
      workbook.workbook.add_worksheet(name: "Errors") do |sheet|
        errors.each do |error|
          sheet.add_row [error]
        end
      end
    end

    def generate_error_file(workbook, uploaded_file)
      original_file_path = uploaded_file.path
      workbook.serialize(original_file_path)
      original_file_path
    end
end
