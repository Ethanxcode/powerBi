  # frozen_string_literal: true

  module BaseHelper
    def daithuan_title(title = nil)
      if title
        content_for(:title) { title }
      else
        content_for?(:title) ? content_for(:title) : nil
      end
    end

    DAITHUAN_URL_REGEX = %r{\Ahttps?://\S+\z}
    DAITHUAN_IMAGE_EXT = %w[png jpg jpeg gif].freeze

    def daithuan_format_value(key, value)
      if value.is_a?(Numeric) && !key.to_s.end_with?("id") && !key.to_s.start_with?("id")
        number_with_delimiter(value)
      elsif value.is_a?(String) && value =~ DAITHUAN_URL_REGEX
        # see if image or link
        if Daithuan.images &&
          (key.include?("image") ||
          DAITHUAN_IMAGE_EXT.include?(value.split(".").last.split("?").first.try(:downcase)))
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

    def daithuan_js_var(name, value)
      "var #{name} = #{json_escape(value.to_json(root: false))};".html_safe
    end

    def daithuan_series_name(k)
      k.nil? ? "null" : k.to_s
    end

    def last_sync_time_for_table(record_name)
      begin
        sync_times_record = SyncTimesRecord.find_by(record_name:)
        if sync_times_record
          sync_times_record.last_sync_time.strftime("%I:%M:%S %p - %d/%m/%Y")
        else
          "Last sync information not available"
        end
      rescue => e
        Rails.logger.error "Error retrieving last sync time for table #{table_name}: #{e.message}"
        "Error retrieving last sync time"
      end
    end
  end
