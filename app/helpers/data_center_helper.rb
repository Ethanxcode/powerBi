# frozen_string_literal: true
# rubocop: disable all

	module DataCenterHelper
		include BaseHelper

		DMS = "DMS"
		SEASOFT = ""

	def user_table_headers
		[
			'Thao tác', 'STT', 'Tài khoản', 'SDT', 'Email',' Họ tên', 'Quyền hạn', 'Trạng thái'
		]
	end
	def sync_seasoft_attributes
    {
      "ID Chi tiết đơn hàng" => :order_detail_id,
      "STT" => :no, # Tên tạm thời cho số thứ tự
      "Trạng thái SEASOFT" => :seasoft_status,
      "Trạng thái DMS" => :dms_status,
      "Mã đơn hàng" => :order_code,
      "Mã khách hàng" => :customer_code,
      "Tên khách hàng" => :customer_name,
      "Điện thoại" => :phone_number,
      "Địa chỉ giao hàng" => :delivery_address,
      "Ngày bán hàng" => :order_date,
      "Mã SKU" => :sku_code,
      "Tên SKU" => :sku_name,
      "Đơn vị tính" => :unit_of_measure,
      "Số lượng bán" => :quantity_sold,
      "Khuyến mãi" => :promotion,
      "Đơn giá (-VAT)" => :unit_price_minus_vat,
      "Đơn giá (+VAT)" => :unit_price_plus_vat,
      "%CK/ĐH" => :discount_percent_order,
      "%CK/SP" => :discount_percent_sku,
      "CKĐH" => :order_discount,
      "CKSP" => :sku_discount,
      "Thành tiền TT" => :total_amount_before_tax,
      "TT (chưa VAT, đã trừ CK)" => :total_amount_after_discount,
      "Tiền VAT" => :vat_amount,
      "Thành tiền (+VAT)" => :total_amount_after_vat,
      "Tổng TT trước VAT" => :total_amount_before_tax_vat,
      "Tổng CK" => :total_discount,
      "Tổng TT (chưa VAT, đã trừ CK)" => :total_amount_before_tax_discount,
      "Tổng tiền VAT" => :total_vat_amount,
      "Tổng TT (+VAT)" => :total_amount_after_vat,
      "Số đơn hàng" => :order_count,
      "Mã Vùng" => :region_code,
      "Tên Vùng" => :region_name,
      "Mã Khu vực" => :area_code,
      "Tên Khu vực" => :area_name,
      "Mã NPP" => :distributor_code,
      "Tên NPP" => :distributor_name,
      "Mã RSM" => :rsm_code,
      "Tên RSM" => :rsm_name,
      "Mã ASM" => :asm_code,
      "Tên ASM" => :asm_name,
      "Mã SUP" => :sup_code,
      "Tên SUP" => :sup_name,
      "Mã SALE" => :sale_code,
      "Tên SALE" => :sale_name,
      "Kênh" => :channel,
      "Viếng thăm" => :visit,
      "Mã Brand" => :brand_code,
      "Ngày tạo" => :brand_name,
      "Tên Brand" => :created_at,
      "Ngày cập nhật" => :updated_at
    }
  end
	# User Table Headers
	# def user_table_headers
	# 	[
	# 		'Thao tác', 'STT', 'Tên nick', 'Mã quốc gia', 'Số điện thoại', 'Mật khẩu', 'Mật khẩu IoT', 'Mật khẩu chính', 'Email', 'Mã', 'Tên',
	# 		'Tên đầu', 'Tên cuối', 'Giới tính', 'ID Facebook', 'Ngày sinh', 'ID Zalo', 'ID Google', 'Địa chỉ', 'Ảnh đại diện',
	# 		'Mã xác nhận', 'Mã hết hạn', 'ID phân phối', 'ID vai trò', 'Mã vai trò', 'Tên vai trò', 'ID cha', 'Ghi chú',
	# 		'Loại người dùng', 'Loại trung tâm giao hàng', 'Thời gian bắt đầu gọi', 'Thời gian kết thúc gọi', 'ID khu vực',
	# 		'Ngày đăng ký', 'Điểm', 'Điểm đã sử dụng', 'Điểm bị khóa', 'Điểm còn lại', 'Xếp hạng mục tiêu điểm', 'Nhận tại cửa hàng', 'Mã xác nhận SMS', 'Thời gian SMS', 'Mã công ty', 'Tên công ty', 'Mã cửa hàng', 'Tên cửa hàng', 'Mã nhóm', 'Tên nhóm', 'Số lượng tối đa mỗi ngày', 'Số lượng còn lại (mỗi lần)', 'Số tiền tối thiểu', 'Số tiền tối đa',
	# 		'Thể tích tối đa', 'ID trung tâm phân phối', 'Mã trung tâm phân phối', 'Tên trung tâm phân phối', 'Số tài khoản ngân hàng', 'Chi nhánh ngân hàng', 'Thuế', 'Là đối tác', 'Doanh thu dự kiến', 'Tình trạng tài khoản', 'ID tham chiếu', 'Mã tham chiếu', 'Tên tham chiếu', 'Số điện thoại tham chiếu', 'Số cấp bậc', 'ID cấp 1', 'Mã cấp 1', 'Tên cấp 1', 'ID cấp 2', 'Mã cấp 2', 'Dữ liệu cấp 2', 'ID cấp 3', 'Mã cấp 3', 'Dữ liệu cấp 3', 'ID nhà phân phối', 'Mã nhà phân phối', 'Tên nhà phân phối', 'Đăng ký đại lý', 'Đang hoạt động', 'Đã xóa', 'Is Super', 'Is Logged','Turn Rotation', 'Is Transport','Is VTP', 'Is VNP', 'Is Grab', 'Is Self Delivery', 'ID giới thiệu', 'Mã nhóm tạm', 'Mã phường', 'Tên phường', 'Mã quận', 'Tên quận', 'Mã thành phố', 'Tên thành phố', 'Nhận khuyến mãi', 'Chấp nhận điều khoản', 'Tổng doanh thu', 'Sẵn sàng làm việc', 'ID hình ảnh', 'Số CMND', 'Ngày cấp CMND', 'Nơi cấp CMND', 'ID khu vực trung tâm phân phối', 'ID thẻ', 'Mã giới thiệu', 'Thời gian bắt đầu làm việc', 'Loại đối tác', 'Vĩ độ', 'Nhân viên cấp trên',
	# 		'Kinh độ', 'Thời gian cập nhật xếp hạng', 'ID nhà bán', 'Mã nhà bán', 'Tên nhà bán', 'Số điện thoại nhà bán', 'Email nhà bán', 'Nguồn', 'IP POS', 'Cổng POS', 'Is Mutosi', 'Mã kho', 'Is Giao hàng', 'Loại tài khoản', 'Mã SAP', 'Kiểm tra Elite', 'Ảnh thư viện', 'Mã DMS', 'Điều kiện trao đổi số', 'Kênh', 'Loại kênh', 'Hệ thống', 'Loại kinh doanh', 'Số lượng tủ lạnh', 'Nhân viên bán hàng', 'Chi nhánh', 'Khu vực', 'Nhập', 'ID đơn vị DMS', 'Vị trí bán hàng', 'Chấp nhận đến ngày', 'ID đăng ký đối tác', 'Tạo từ', 'Mã khu vực', 'Lần thanh toán cuối cùng', 'Lần đặt hàng cuối cùng', 'Địa chỉ 2', 'Tên 2', 'Số DTPNHT', 'Thời gian tối thiểu', 'Người đại diện pháp lý', 'Mã số thuế', 'Địa chỉ pháp lý', 'Tên thành phần pháp lý', 'Ngày tạo', 'Ngày cập nhật', 'Ngày xóa', 'Đã xóa bởi', 'Đã cập nhật bởi'
	# 	]
	# end

end
