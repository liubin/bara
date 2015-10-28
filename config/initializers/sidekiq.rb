# https://github.com/mperham/sidekiq/wiki/Using-Redis

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://10.128.17.10:6379/12' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://10.128.17.10:6379/12' }
end