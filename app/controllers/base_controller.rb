# frozen_string_literal: true

require "faraday"
require "json"
# require 'redis'
require "axlsx"
require "roo"

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
          { path: "sync-seasoft", icon: "icons/carbon_cloud-data-ops.svg", name: "Đồng bộ từ Seasoft" },
          {
            path: "sync-dms", icon: "icons/material-symbols-light_data-table-outline-sharp.svg",
            name: "Đồng bộ từ DMS"
          },
          { path: sync_files_path, icon: "icons/pepicons-pencil_file.svg", name: "Đồng bộ từ file" }
        ]
      }
    ]
  end
end

class DataImporter
  # Initializes a new instance of the DataImporter class.
  #
  # @param api_ [String] The API endpoint to import data from.
  def initialize(api_)
    @base_url = ENV["BASE_API_URL"]
    @api_url = "#{@base_url}/#{api_}"

    # @redis = Redis.new
  end

  # Imports data from the API.
  #
  # @return [Array] The parsed API response as an array of objects, or nil if the import failed.
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

    # Fetches data from the API.
    #
    # @return [Faraday::Response, nil] The API response, or nil if the request failed.
    def fetch_data_from_api
      conn = Faraday.new(url: @api_url)
      begin
        response = conn.get(@api_url) do |req|
          req.headers["Content-Type"] = "application/json"
          req.headers["Accept"] = "application/json"
          req.headers["connection"] = "keep-alive"
        end

        return response if response.success?

        Rails.logger.error("Request failed with status code #{response&.status}")
        nil
      rescue Faraday::ConnectionFailed => e
        Rails.logger.error("Connection failed: #{e.message}")
        # render plain: "Connection failed: #{e.message}", status: :service_unavailable
        nil
      end
    end

    # Parses the API response.
    #
    # @param response_body [String] The response body to parse.
    # @return [Array] The parsed response as an array of objects, or an empty array if parsing failed.
    def parse_api_response(response_body)
      JSON.parse(response_body)
    rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse API response: #{e.message}")
      []
    end
end
