# frozen_string_literal: true

class SyncTimesRecord < ApplicationRecord
  validates :last_sync_time, presence: true

  def self.update_sync_time(record_name, ip_address = "SYSTEM", status = "success", description = nil)
    transaction do
      last_sync_time = find_or_initialize_by(record_name:, sync_by: ip_address) do |record|
        record.status = status
        record.description = description
      end

      last_sync_time.last_sync_time = Time.zone.now
      last_sync_time.sync_by = ip_address

      if last_sync_time.new_record?
        Rails.logger.info "Last sync time by #{ip_address} for table #{record_name} created successfully."
        puts "Last sync time by #{ip_address} for table #{record_name} created successfully."
      else
        Rails.logger.info "Last sync time by #{ip_address} for table #{record_name} updated successfully."
        puts "Last sync time by #{ip_address} for table #{record_name} updated successfully."
      end

      last_sync_time.save!
    end
  rescue StandardError => e
    Rails.logger.error "Error updating last sync time for table #{record_name}: #{e.message}"
    find_or_initialize_by(record_name:, sync_by: ip_address) do |record|
      record.status = "failure"
      record.description = e.message
    end
  end
end
