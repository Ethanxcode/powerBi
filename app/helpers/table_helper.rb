# frozen_string_literal: true
# rubocop: disable all
    # Documentation for TableHelper
    module TableHelper

      def display_status(value)
        icon = determine_icon(value.downcase)
        image_tag(icon, class: 'mr-[5px]') + content_tag(:span, value)
      end

      private

      def determine_icon(value)
        case value
        when 'approved'
          'icons/approved.svg'
        when 'disable'  
          'icons/disable.svg'
        when 'error'
          'icons/error.svg'
        else
          ''
        end
      end
    end