  # frozen_string_literal: true
  # rubocop:disable all
  # Controller responsible for managing the data center functionality.
  # This module represents the V1 version of the DataCenterController.
  class UsersController < BaseController
    include UsersHelper

    before_action :setup, only: [:index, :export]

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
        { value: "30", text: "30 Ngày" },
        { value: "90", text: "" },
        { value: "custom", text: "Tùy chỉnh" }
      ]

      # Define options for items per page selection.
      @itemsPerpage = [
        { value: "10", text: "10" },
        { value: "20", text: "20" },
        { value: "30", text: "30" },
        { value: "custom", text: "Tùy chỉnh" }
      ]

      # Generate sample order data.
      @orders = (1..4).map do |i|
        {
          name: "horizon_ui_pro#{i}",
          status: %w[Approved Disable Error].sample,
          date: date.strftime("%d %b %Y"),
          progress: rand(0..100)
        }
      end
    end



    # Retrieves data for the edit page.
    def edit
      @data = User.find(params[:id])
    end

    # Retrieves data for the show page.
    def show
      @data = User.find(params[:id])
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
          LastSyncTime.update_last_sync_time("users", ip_address)
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
        title_style = style.add_style(
          bg_color: "e64422", fg_color: "000000", b: true,
          alignment: { horizontal: :center })
        highlight_cell = style.add_style(
          bg_color: "FFFF00",
          border: Axlsx::STYLE_THIN_BORDER,
          alignment: { horizontal: :center },
          format_code: "# ###.##")
        date_cell = style.add_style(format_code: "yyyy-mm-dd", border: Axlsx::STYLE_THIN_BORDER)
        highlight_cell = wb.styles.add_style(bg_color: "FF0000", type: :dxf)

        wb.add_worksheet(name: "Danh sách") do |sheet|
          sheet.add_row users_attributes.map(&:titleize), style: title_style
          @data.each_with_index do |user, index|
            sheet.add_row [
                user.id, index + 1, user.account, user.phone_number,
                user.email, user.full_name, user.permission, user.status ? "Hoạt động" : "Không hoạt động",
                user.created_at, user.updated_at
                ],
              style: [nil, highlight_cell, date_cell]
            sheet.rows.last.cells.first.u = :single

            sheet.add_hyperlink location: url_for(action: "show", id: user.id, only_path: false),
              ref: sheet.rows.last.cells.first
          end
        end
      end

      send_data p.to_stream.read, filename: "Danh sách khách hàng #{Time.zone.now.strftime('%d-%m-%Y')}.xlsx"
    end

    private

    def setup
      @q = User.ransack(params[:query])
      @pagy, @data = pagy(@q.result.all, items: params[:per_page] || 10)
    end

      def update
        # @pagy, @data = pagy(User.all)
        # respond_to do |format|
        #   format.turbo_stream
        #   format.html { redirect_to user_path }
        # end
      end

      # Inserts data from API if @result is present.
      def insert_data_from_api
        User.insert_from_api(@result)
      end

      # Prepares data for retrieval from the host API.
      def prepare_get_data_from_host
        api_path = "v0/datawarehouse/get-list-user-export"
        # importer = DataImporter.new(api_path)
        importer.import_data
      end
  end
