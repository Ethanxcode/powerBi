  # frozen_string_literal: true

  # Controller responsible for managing the warehouse functionality.
  class OverviewController < BaseController
    helper TableHelper
    before_action :index

    before_action :set_dashboard, only: [:show, :edit, :update, :destroy, :refresh]

    # Sets the data for the warehouse.
    def index
      start_date = DateTime.new(2020, 1, 1)
      end_date = DateTime.new(2023, 12, 31)
      date = start_date + (end_date - start_date) * rand

      @employees = Array.new(4) do |i|
        {
          ma_nhan_vien: "NV#{i + 1}",
          ten_nhan_vien: "Employee #{i + 1}",
          luong: rand(10_000..20_000),
          thuong: rand(1000..5000)
        }
      end

      @bigData = Array.new(4) do |i|
        {
          ma_nhan_vien: "NV#{i + 1}",
          ten_nhan_vien: "Employee #{i + 1}",
          don_vi: "Đơn vị #{i + 1}",
          so_don_hang: rand(1..100),
          so_hoa_don: rand(50..200),
          ngay_hoa_don: date.strftime("%d %b %Y"),
          khu_vuc: "Khu vực #{i + 1}",
          mien: "Miền #{i + 1}",
          he_thong: "Hệ thống #{i + 1}",
          kenh: "Kênh #{i + 1}",
          ma_khach_hang: "KH#{rand(1000..9999)}",
          ten_khach_hang: "name #{rand(1000..9999)}",
          luong: rand(10_000..20_000),
          thuong: rand(1000..5000)
        }
      end

      @dateRange = [
        { value: "30", text: "30 Ngày" },
        { value: "90", text: "" },
        { value: "custom", text: "Tùy chỉnh" }
      ]

      @itemsPerpage = [
        { value: "10", text: "10" },
        { value: "20", text: "20" },
        { value: "30", text: "30" },
        { value: "custom", text: "Tùy chỉnh" }
      ]

      @orders = Array.new(4) do |i|
        {
          name: "horizon_ui_pro#{i + 1}",
          status: %w[Approved Disable Error].sample,
          date: date.strftime("%d %b %Y"),
          progress: rand(0..100)
        }
      end
    end



    def new
      @dashboard = Blazer::Dashboard.new
    end

    def create
      @dashboard = Blazer::Dashboard.new
      # use creator_id instead of creator
      # since we setup association without checking if column exists
      @dashboard.creator = blazer_user if @dashboard.respond_to?(:creator_id=) && blazer_user

      if update_dashboard(@dashboard)
        redirect_to dashboard_path(@dashboard)
      else
        render_errors @dashboard
      end
    end

    def show
      @queries = @dashboard.dashboard_queries.order(:position).preload(:query).map(&:query)
      @queries.each do |query|
        @success = process_vars(query.statement_object)
      end
      @bind_vars ||= []

      @smart_vars = {}
      @sql_errors = []
      @data_sources = @queries.map { |q| Blazer.data_sources[q.data_source] }.uniq
      @bind_vars.each do |var|
        @data_sources.each do |data_source|
          smart_var, error = parse_smart_variables(var, data_source)
          ((@smart_vars[var] ||= []).concat(smart_var)).uniq! if smart_var
          @sql_errors << error if error
        end
      end

      add_cohort_analysis_vars if @queries.any?(&:cohort_analysis?)
    end

    def edit
    end

    def update
      if update_dashboard(@dashboard)
        redirect_to dashboard_path(@dashboard, params: variable_params(@dashboard))
      else
        render_errors @dashboard
      end
    end

    def destroy
      @dashboard.destroy
      redirect_to root_path
    end

    def refresh
      @dashboard.queries.each do |query|
        refresh_query(query)
      end
      redirect_to dashboard_path(@dashboard, params: variable_params(@dashboard))
    end

    private

      def dashboard_params
        params.require(:dashboard).permit(:name)
      end

      def set_dashboard
        @dashboard = Blazer::Dashboard.find('1-nhom-bao-cao-1')
      end

      def update_dashboard(dashboard)
        dashboard.assign_attributes(dashboard_params)
        Blazer::Dashboard.transaction do
          if params[:query_ids].is_a?(Array)
            query_ids = params[:query_ids].map(&:to_i)
            @queries = Blazer::Query.find(query_ids).sort_by { |q| query_ids.index(q.id) }
          end
          if dashboard.save
            if @queries
              @queries.each_with_index do |query, i|
                dashboard_query = dashboard.dashboard_queries.where(query_id: query.id).first_or_initialize
                dashboard_query.position = i
                dashboard_query.save!
              end
              if dashboard.persisted?
                dashboard.dashboard_queries.where.not(query_id: query_ids).destroy_all
              end
            end
            true
          end
        end
      end
  end
