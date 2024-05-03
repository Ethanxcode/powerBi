require 'faraday'
require 'json'
require 'uri'

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
     	puts "Request failed with status code #{response&.status}"
      error = Errors::ErrorsHandler.send(:error_class, response&.status, response)
			puts error
      raise error
    rescue Faraday::ConnectionFailed => e
      Rails.logger.error("Connection failed: #{e.message}")
      nil
    end
  end

  def parse_api_response(response_body)
    parsed_response = JSON.parse(response_body)
    parsed_response = { "data" => parsed_response } if parsed_response.is_a?(Array)
    parsed_response
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse API response: #{e.message}")
    puts "Failed to parse API response: #{e.message}"
    error_data = Errors::ErrorsHandler.handle_record_invalid(e, response_body)
		puts error_data
    raise error_data
  end
end