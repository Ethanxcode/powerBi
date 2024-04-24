# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap
# pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true

pin "application"
pin "stimulus-notification" # @2.2.0
pin "hotkeys-js" # @3.13.7
pin "stimulus-use" # @0.52.2
pin "stimulus-content-loader" # @4.2.0
pin_all_from "app/javascript/controllers", under: "controllers"
