# frozen_string_literal: true

# In error_handler.rb
module Errors
  class ErrorsHandler < Api::Errors::BaseHandler
    HTTP_ERROR_CODE = {
      BAD_REQUEST_CODE: 400,
      UNAUTHORIZED_CODE: 401,
      NOT_FOUND_CODE: 404,
      ACCESS_ERROR_CODE: 405,
      API_REQUSTS_QUOTA_REACHED_CODE: 429,
      UNKNOW_ERROR_CODE: 500
    }.freeze

    class << self
      def handle_record_invalid(error, data)
        Rails.logger.error "Failed to update records: #{error.message}"
        { id: data["id"], errors: [error.message] }
      end

      private

        def error_class(status_code, response)
          case status_code
          when HTTP_ERROR_CODE[:BAD_REQUEST_CODE]
            Api::Errors::BadRequestError.new(status_code, response)
          when HTTP_ERROR_CODE[:UNAUTHORIZED_CODE]
            Api::Errors::UnauthorizedError.new(status_code, response)
          when HTTP_ERROR_CODE[:ACCESS_ERROR_CODE]
            Api::Errors::AccessError.new(status_code, response)
          when HTTP_ERROR_CODE[:NOT_FOUND_CODE]
            Api::Errors::NotFoundError.new(status_code, response)
          when HTTP_ERROR_CODE[:API_REQUSTS_QUOTA_REACHED_CODE]
            Api::Errors::ApiRequestsQuotaReachedError.new(status_code, response)
          else
            Api::Errors::Base.new(status_code, response)
          end
        end
    end
  end
end
