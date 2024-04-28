# frozen_string_literal: true

class SyncTimesRecord < ApplicationRecord
  validates :last_sync_time, presence: true

  def self.update_sync_time(record_name, ip_address = "ADMIN")
    transaction do
      last_sync_time = find_or_initialize_by(record_name:)
      last_sync_time.last_sync_time = Time.zone.now
      last_sync_time.sync_by = ip_address

      if last_sync_time.new_record?
        Rails.logger.info "Last sync time by #{ip_address} for table #{record_name} created successfully."
        # flash[:notice] = "Last sync time by #{ip_address} for table #{table_name} created successfully."
      else
        Rails.logger.info "Last sync time by #{ip_address} for table #{record_name} updated successfully."
      end
      last_sync_time.save!
    end
  rescue StandardError => e
    Rails.logger.error "Error updating last sync time for table #{record_name}: #{e.message}"
  end
end
