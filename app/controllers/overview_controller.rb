  # frozen_string_literal: true

  # Controller responsible for managing the warehouse functionality.
  class OverviewController < BaseController
    helper TableHelper
    before_action :index

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
  end
