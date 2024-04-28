# frozen_string_literal: true
# rubocop: disable all

module SyncSeasoftHelper
  include BaseHelper

  def sync_seasoft_attributes
    {
      "ID Chi tiết đơn hàng" => :order_detail_id,
      "STT" => :index, # Tên tạm thời cho số thứ tự
      "Trạng thái SEASOFT" => :seasoft_status,
      "Mã đơn hàng" => :order_code,
      "Mã khách hàng" => :customer_code,
      "Tên khách hàng" => :customer_name,
      "Điện thoại" => :phone_number,
      "Địa chỉ giao hàng" => :shipping_address,
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
