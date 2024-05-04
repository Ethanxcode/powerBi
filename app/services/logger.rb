# frozen_string_literal: true

class Logger
  def initialize(log_file)
    @log_file = log_file
  end

  def log(message)
    File.open(@log_file, "a") do |file|
      file.puts("[#{Time.zone.now}] #{message}")
    end
  end
end
