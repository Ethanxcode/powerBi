# frozen_string_literal: true
# rubocop: disable all

	module UsersHelper
		include BaseHelper

	def users_table_headers
		[
			'Thao tác', 'STT', 'Tài khoản', 'SDT', 'Email',' Họ tên', 'Quyền hạn', 'Trạng thái', 'Ngày tạo', 'Ngày cập nhật'
		]
	end

	def display_boo_status(status)
		if status
			html = <<-HTML
				<div>
					<label class="relative inline-flex items-center  cursor-pointer">
						<input type="checkbox" value="" class="sr-only peer" checked>
						<div class="w-[43px] h-[22px] bg-gray-200 rounded-full peer  peer-focus:ring-2 ring-2 -ring--black-5% hover:-ring--color-green-3  peer-focus:-ring--color-green-3  peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:-border--text-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:-bg--color-green-4  after:rounded-full after:h-5 after:w-5 after:transition-all  peer-checked:-bg--color-green-5"></div>

					</label>
				</div>
			HTML
		else
			html = <<-HTML
				<div>
					<label class="relative inline-flex items-center  cursor-pointer">
						<input type="checkbox" value="" class="sr-only peer">
						<div class="w-[43px] h-[22px] bg-gray-200 rounded-full peer  peer-focus:ring-2 ring-2 -ring--black-5% hover:-ring--color-green-3  peer-focus:-ring--color-green-3  peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:-border--text-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:-bg--color-green-4  after:rounded-full after:h-5 after:w-5 after:transition-all  peer-checked:-bg--color-green-5"></div>

					</label>
				</div>
			HTML
		end
		html.html_safe
	end



end
