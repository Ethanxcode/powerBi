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

class DataImporter
  def initialize(root_path, params = {})
    encoded_params = URI.encode_www_form(params)
    @path = params.empty? ? root_path : "#{root_path}?#{encoded_params}"
end

  def import_data
    response = fetch_data_from_api
    if response&.success?
      parse_api_response(response.body)
    else
      Rails.logger.error("Failed to fetch data from API: #{response&.status}")
      nil
    end
  end

  private

    def fetch_data_from_api
      conn = Faraday.new(url: @path)
      begin
        response = conn.get(@path) do |req|
          req.headers["Accept"] = "application/json, text/plain, */*"
          req.headers["Accept-Language"] = "vi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5"
          req.headers["Cache-Control"] = "no-cache"
          req.headers["Connection"] = "keep-alive"
          req.headers["x-api-key"] = "88"
        end

        return response if response.success?

        Rails.logger.error("Request failed with status code #{response&.status}")
        error = Errors::ErrorsHandler.send(:error_class, response&.status, response)
        raise error
      rescue Faraday::ConnectionFailed => e
        Rails.logger.error("Connection failed: #{e.message}")
        # render plain: "Connection failed: #{e.message}", status: :service_unavailable
        nil
      end
    end

    def parse_api_response(response_body)
      parsed_response = JSON.parse(response_body)
      parsed_response = { "data" => parsed_response } if parsed_response.is_a?(Array)
      parsed_response
    rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse API response: #{e.message}")
      error_data = Errors::ErrorsHandler.handle_record_invalid(e, response_body)
      raise error_data
    end
end
