  # frozen_string_literal: true

  # Controller responsible for managing the warehouse functionality.
  class SyncSeasoftsController < BaseController
    include SyncSeasoftHelper
    before_action :setup, only: [:index, :export]

    def index
    end

    def export
      p = Axlsx::Package.new
      wb = p.workbook

      wb.styles do |style|
        title_style = style.add_style(
          bg_color: "ededed", fg_color: "000000", b: true,
          alignment: { horizontal: :center })

        wb.add_worksheet(name: "Đồng bộ từ file") do |sheet|
          sheet.add_row sync_dms_attributes.keys.map(&:titleize), style: title_style
          @data.each_with_index do |item, index|
            sync_files_table_headers.values.map do |field|
              value = nil
              if field == :index
                value = index + 1
              else
                value = item.send(field)
                value = value.strftime("%Y-%m-%d") if value.is_a?(Time)
              end
              value
            end

          end
        end
      end

      send_data p.to_stream.read, filename: "Đồng bộ từ file#{Time.zone.now.strftime('%d-%m-%Y')}.xlsx"
    end

    def edit
      @detail = SyncSeasoft.find(params[:id])
    end

    # Retrieves data for the show page.
    def show
      # @data_center = User.find(params[:id])
    end

    private

      def setup
        @q = SyncSeasoft.ransack(params[:query])
        @pagy, @data = pagy(@q.result.all, items: params[:per_page] || 10)
      end
  end
