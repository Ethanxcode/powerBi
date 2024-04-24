# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
V1::User.create!(
  account: "DT0000",
  phone_number: "0867833989",
  email: "trannguyendanhuy2904@gmail.com",
  full_name: "Trần Nguyễn Đang Huy",
  permission: "admin",
  status: "active"
)
