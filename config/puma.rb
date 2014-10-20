threads (ENV['PUMA_MIN_THREADS']|| 0),(ENV['PUMA_MAX_THREADS']|| 16)
workers (ENV['PUMA_WORKERS'] || 2)

preload_app!

on_worker_boot do
  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] || Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    config['pool']              = ENV['DB_POOL'] || 5
    ActiveRecord::Base.establish_connection(config)
  end
end