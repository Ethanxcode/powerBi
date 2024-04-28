# frozen_string_literal: true
# rubocop: disable all

module SyncDmsHelper
  include BaseHelper

  def sync_dms_attributes
    {
      "ID Chi tiết đơn hàng" => :id_order_detail,
      "STT" => :index,
      "Trạng thái DMS" => :dms_status,
      "Mã đơn hàng" => :order_code,
      "Mã khách hàng" => :customer_code,
      "Tên khách hàng" => :customer_name,
      "Điện thoại" => :customer_phone ,
      "Địa chỉ giao hàng" => :shipping_address,
      "Ngày bán hàng" => :order_date ,
      "Mã sản phẩm" => :product_code ,
      "Tên sản phẩm" => :product_name ,
      "Đơn vị tính" => :unit_name ,
      "Số lượng bán" => :quantity ,
      "Khuyến mãi" => :is_promotion ,
      "Đơn giá (-VAT)" => :price_before_tax ,
      "Đơn giá (+VAT)" => :price ,
      "%CK/ĐH" => :"%CK/DH",
      "%CK/SP" => :"%CK/SP",
      "CKĐH" => :"CKĐH",
      "CKSP" => :"CKSP",
      "Thành tiền TT" => :tt_tt ,
      "TT (chưa VAT, đã trừ CK)" => :tt_chua_vat_da_tru_ck ,
      "Tiền VAT" => :tien_vat ,
      "Thành tiền (+VAT)" => :tt_vat ,
      "Tổng TT trước VAT" => :tong_tt_truoc_vat ,
      "Tổng CK" => :tong_ck ,
      "Tổng TT (chưa VAT, đã trừ CK)" => :tong_tt_chua_vat_da_tru_ck ,
      "Tổng tiền VAT" => :tong_tien_vat  ,
      "Tổng TT (+VAT)" => :tong_tt_vat   ,
      "Số đơn hàng" => :bill_no ,
      "Mã Khu vực" => :area_code,
      "Tên Khu vực" => :area_name,
      "Mã Vùng" => :region_code,
      "Tên Vùng" => :region_name,
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
      "Tên Brand" => :brand_name,
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
