# frozen_string_literal: true

class ImportJob < ActiveJob::Base
  queue_as :default

  def perform(result)
  end
end
