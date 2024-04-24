    # frozen_string_literal: true

    module OverviewHelper
      def title(title = nil)
        if title
          content_for(:title) { title }
        else
          content_for?(:title) ? content_for(:title) : nil
        end
      end
      BLAZER_URL_REGEX = %r{\Ahttps?://\S+\z}
      BLAZER_IMAGE_EXT = %w[png jpg jpeg gif].freeze

      def blazer_format_value(key, value)
        if value.is_a?(Numeric) && !key.to_s.end_with?("id") && !key.to_s.start_with?("id")
          number_with_delimiter(value)
        elsif value.is_a?(String) && value =~ BLAZER_URL_REGEX
          # see if image or link
          if Blazer.images && (key.include?("image") || BLAZER_IMAGE_EXT.include?(value.split(".").last.split("?").first.try(:downcase)))
            link_to value, target: "_blank", rel: "noopener" do
              image_tag value, referrerpolicy: "no-referrer"
            end
          else
            link_to value, value, target: "_blank", rel: "noopener"
          end
        else
          value
        end
      end

      def blazer_js_var(name, value)
        "var #{name} = #{json_escape(value.to_json(root: false))};".html_safe
      end

      def blazer_series_name(k)
        k.nil? ? "null" : k.to_s
      end
    end
