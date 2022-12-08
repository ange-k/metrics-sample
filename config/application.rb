require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MetricsSample
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    # logger
    config.rails_semantic_logger.format = :json
    config.log_tags = {
      request_id: :request_id,
      ip:         :remote_ip,
    }
    if ENV["RAILS_LOG_TO_STDOUT"].present?
      $stdout.sync = true
      config.rails_semantic_logger.add_file_appender = false
      config.semantic_logger.add_appender(io: $stdout, formatter: :json)
    end
  end
end
