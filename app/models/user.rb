# frozen_string_literal: true
# rubocop:disable all
# app/models/user.rb
  class User < ApplicationRecord
    # validates :nick_name, presence: true, length: { maximum: 50 }
    # validates :email, presence: true, length: { maximum: 50 }, uniqueness: true
    # validates :password, presence: true, length: { minimum: 6 }, confirmation: true
    # validates :phone, presence: true, length: { maximum: 50 }

    def self.ransackable_attributes(auth_object = nil)
      %w[id account phone_number email full_name permission status created_at updated_at]
    end

    def self.ransackable_associations(auth_object = nil)
      []
    end


    # Clear the connection cache
    User.connection.clear_cache!

    def self.insert_from_api(agrs)
      errors = []

      User.transaction do
        agrs["data"].each do |user_data|
          begin
            # Tạo một hash để lưu trữ các trường có giá trị để cập nhật hoặc tạo người dùng
            attributes_to_update = {}

            user_data.each do |key, value|
              if value.present? && User.column_names.include?(key)
                attributes_to_update[key] = value
              end
            end

            next if attributes_to_update.empty?

            user = User.find_or_initialize_by(id: user_data['id'])

            user.attributes = attributes_to_update
            if user.save!
              Rails.logger.info "User updated successfully with ID: #{user_data['id']}"
            else
              Rails.logger.error "Failed to update user: #{user.errors.full_messages.join(", ")}"
              errors << { id: user.id, errors: user.errors.full_messages }
            end
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error "Failed to update records: #{e.message}"
            errors << { id: user&.id, errors: [e.message] }
          end
        end
      end

      errors
    end


  end
