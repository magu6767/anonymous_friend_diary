require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = true
  config.active_storage.service = :local
  config.force_ssl = true
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new
  config.hosts << "anonymous-friend-diary.com"
  config.hosts << "172.30.0.63" # ELBのIPアドレス

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
  host = 'https://anonymous-friend-diary.com'
  config.action_mailer.default_url_options = { host: host }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: Rails.application.credentials.smtp[:endpoint],
    user_name: Rails.application.credentials.smtp[:username],
    password: Rails.application.credentials.smtp[:password],
    enable_starttls: true,
    port: 587,
    authentication: :login
  }
end
