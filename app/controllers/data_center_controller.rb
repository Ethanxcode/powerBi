# frozen_string_literal: true
# rubocop:disable all
# Controller responsible for managing the data center functionality.
# This module represents the V1 version of the DataCenterController.
  class DataCenterController < BaseController
    helper DataCenterHelper


    before_action :set_data_centers, only: [:index, :export]



    # Retrieves data for the index page.
    def index
      # Generate a random date within a specific range.
      start_date = DateTime.parse("2020-01-01")
      end_date = DateTime.parse("2023-12-31")
      date = start_date + rand * (end_date - start_date)




      # Generate sample employee data.
      @employees = (1..4).map do |i|
        {
          ma_nhan_vien: "NV#{i}",
          ten_nhan_vien: "Employee #{i}",
          luong: rand(10_000..20_000),
          thuong: rand(1000..5000)
        }
      end

      # Define options for date range selection.
      @dateRange = [
        { value: '30', text: '30 Ngày' },
        { value: '90', text: '' },
        { value: 'custom', text: 'Tùy chỉnh' }
      ]

      # Define options for items per page selection.
      @itemsPerpage = [
        { value: '10', text: '10' },
        { value: '20', text: '20' },
        { value: '30', text: '30' },
        { value: 'custom', text: 'Tùy chỉnh' }

      ]

      # Generate sample order data.
      @orders = (1..4).map do |i|
        {
          name: "horizon_ui_pro#{i}",
          status: %w[Approved Disable Error].sample,
          date: date.strftime('%d %b %Y'),
          progress: rand(0..100)
        }
      end


    end

    # Retrieves data for the edit page.
    def edit
      @data_center = User.find(params[:id])
    end

    # Retrieves data for the show page.
    def show
      # @data_center = User.find(params[:id])
    end

    def import_from_files
      flash[:notice] = 'Just testing, dude'

      uploaded_file = params[:file]
      ip_address = request.remote_ip
      if uploaded_file
        ActiveRecord::Base.transaction do
          Rails.logger.info "Data retrieval successful. Inserting data from file..."
          SyncFile.import_from_file(uploaded_file)

          Rails.logger.info "Log"

          SyncTimesRecord.update_sync_time('sync_files', ip_address)
          Rails.logger.info "Data insertion complete."
          # Tạm thời bỏi vì chưa có giao diện thành công hay lỗi
          head :no_content
      rescue => e
        Rails.logger.error "An error occurred: #{e.message}"
        Rails.logger.error "Rolling back transaction..."
        puts "Opp! Has errors when transaction"
        raise ActiveRecord::Rollback
        Rails.logger.error "Transaction rolled back successfully."
        # Phản hồi lỗi nếu cần thiết
        head :unprocessable_entity
      end
    else
      Rails.logger.error "Failed to retrieve data from the host API."
      # Chỉ định phản hồi
      head :unprocessable_entity
    end
  rescue NoMethodError
    puts "Opp! Has errors"
      # spreadsheet = Roo::Spreadsheet.open(uploaded_file.path)

      # @data = []

      # spreadsheet.sheets.each do |sheet_name|
      #   sheet = spreadsheet.sheet(sheet_name)

      #   # Get the headers from the first row
      #   headers = sheet.row(1)

      #   # Get the data from the remaining rows
      #   sheet_data = (2..sheet.last_row).map do |i|
      #     row = Hash[[headers, sheet.row(i)].transpose]
      #     row
      #   end

      #   @data += sheet_data
      # end
      # render 'import'
    end

    def import
      Rails.logger.info "Starting perform_task in DataCenterController..."
      @result = prepare_get_data_from_host
      ip_address = request.remote_ip
      if @result
          ActiveRecord::Base.transaction do
            Rails.logger.info "Data retrieval successful. Inserting data from API..."
            insert_data_from_api
            Rails.logger.info "Data insertion complete."
            SyncTimesRecord.update_sync_time('sync_files', ip_address)
            # Tạm thời bỏi vì chưa có giao diện thành công hay lỗi
            head :no_content
        rescue => e
          Rails.logger.error "An error occurred: #{e.message}"
          Rails.logger.error "Rolling back transaction..."
          puts "Opp! Has errors when transaction"
          raise ActiveRecord::Rollback
          Rails.logger.error "Transaction rolled back successfully."
          # Phản hồi lỗi nếu cần thiết
          head :unprocessable_entity
        end
      else
        Rails.logger.error "Failed to retrieve data from the host API."
        # Chỉ định phản hồi
        head :unprocessable_entity
      end
    rescue NoMethodError
      puts "Opp! Has errors"
    end

    # Exports data to an Excel file.
    def export
      p = Axlsx::Package.new
      wb = p.workbook

      wb.styles do |style|
        title_style = style.add_style(bg_color: "e64422", fg_color: "000000", b: true, alignment: { horizontal: :center })
        highlight_cell = style.add_style(bg_color: "FFFF00",
        border: Axlsx::STYLE_THIN_BORDER,
        alignment: { horizontal: :center },
        format_code: '# ###.##')
        date_cell = style.add_style(format_code: "yyyy-mm-dd", border: Axlsx::STYLE_THIN_BORDER)
        highlight_cell = wb.styles.add_style(bg_color: "FF0000", type: :dxf)

        wb.add_worksheet(name: "Danh sách khách hàng") do |sheet|
          sheet.add_row user_table_headers.map(&:titleize), style: title_style
          @data_centers.each do |data_center|
            sheet.add_row [data_center.id, data_center.name, data_center.created_at],
                          style: [nil, highlight_cell, date_cell]

            sheet.rows.last.cells.first.u = :single

            sheet.add_hyperlink location: url_for(action: "show", id: data_center.id, only_path: false),
                                ref: sheet.rows.last.cells.first
          end
        end
      end

      send_data p.to_stream.read, filename: "Danh sách khách hàng #{Time.zone.now.strftime('%d-%m-%Y')}.xlsx"
    end

    private

    # Sets the data centers for the index and export actions.
    def set_data_centers
      @pagy, @data_centers = pagy(User.all)
    end

    # Inserts data from API if @result is present.
    def insert_data_from_api
      User.insert_from_api(@result)
    end

    # Prepares data for retrieval from the host API.
    def prepare_get_data_from_host
      api_path = 'v0/datawarehouse/get-list-user-export'
      importer = DataImporter.new(api_path)
      importer.import_data
    end


  end
