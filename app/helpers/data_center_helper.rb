# frozen_string_literal: true
# rubocop: disable all

	module DataCenterHelper 	
		include BaseHelper

	def user_table_headers
		[
			'Thao tác', 'STT', 'Tài khoản', 'SDT', 'Email',' Họ tên', 'Quyền hạn', 'Trạng thái'
		]	
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

