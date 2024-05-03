# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Datawarehouse
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    config.i18n.default_locale = :vi

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "omni-service.test", "*"
        resource "*", headers: :any, methods: [:get, :post, :options]
      end
    end

    # config.exception_app = self.routes
    config.time_zone = "Hanoi"
    config.assets.enabled = true
    config.assets.compile = true
    config.cache_classes = true
    config.eager_load = true
    config.log_level = :info
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
