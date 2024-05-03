# frozen_string_literal: true
# rubocop: disable all

	module DataCenterHelper
		include BaseHelper

		DMS = "DMS"
		SEASOFT = "SEASOFT"

	  def data_center_attributes
      [
        :id_order_detail,
        :order_status,
        :order_source,
        :order_code,
        :customer_code,
        :customer_name,
        :customer_phone,
        :shipping_address,
        :order_date,
        :product_code,
        :product_name,
        :unit_name,
        :quantity,
        :is_promotion,
        :price_before_tax,
        :price,
        :"%CK/DH",
        :"%CK/SP",
        :ckdh,
        :cksp,
        :tt_tt,
        :tt_chua_vat_da_tru_ck,
        :tien_vat,
        :tt_vat,
        :tong_tt_truoc_vat,
        :tong_ck,
        :tong_tt_chua_vat_da_tru_ck,
        :tong_tien_vat,
        :tong_tt_vat,
        :bill_no,
        :area_code,
        :area_name,
        :region_code,
        :region_name,
        :distributor_code,
        :distributor_name,
        :rsm_code,
        :rsm_name,
        :asm_code,
        :asm_name,
        :sup_code,
        :sup_name,
        :sale_code,
        :sale_name,
        :channel,
        :visit,
        :brand_code,
        :brand_name,
        :created_at,
        :updated_at
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
