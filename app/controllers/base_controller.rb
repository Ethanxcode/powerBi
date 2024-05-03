# frozen_string_literal: true

require "faraday"
require "json"
# require 'redis'
require "axlsx"
require "roo"
require "uri"
require "cgi"

# This is the base controller for version 1 of the API.
class BaseController < ApplicationController
  include Pagy::Backend
  before_action :set_sidebar_items

  # Sets the sidebar items for the view.
  def set_sidebar_items
    @sidebar_items = [
      {
        title: "",
        items: [
          { path: root_path, icon: "icons/iconamoon_home-light.svg", name: "Tổng quan" },
          { path: data_center_index_path, icon: "icons/fluent_data-pie-24-regular.svg", name: "Trung tâm dữ liệu" },
          { path: users_path, icon: "icons/solar_user-outline.svg", name: "Quản lý người dùng" },
          { path: "settings", icon: "icons/ant-design_setting-outlined.svg", name: "Cài đặt & Phân quyền" },
          { path: "logout", icon: "icons/mdi_logout.svg", name: "Đăng xuất" }
        ]
      },
      {
        title: "Hệ thống đồng bộ dữ liệu",
        items: [
          { path: sync_seasofts_path, icon: "icons/carbon_cloud-data-ops.svg", name: "Đồng bộ từ Seasoft" },
          {
            path: sync_dms_path, icon: "icons/material-symbols-light_data-table-outline-sharp.svg",
            name: "Đồng bộ từ DMS"
          },
          { path: sync_files_path, icon: "icons/pepicons-pencil_file.svg", name: "Đồng bộ từ file" }
        ]
      }
    ]
  end
end


