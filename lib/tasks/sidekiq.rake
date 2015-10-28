# bundle exec sidekiq

namespace :sidekiq do
  desc "Stop sidekiq"
  task :stop do
    system "bundle exec sidekiqctl stop #{pidfile}"
  end

  desc "Start sidekiq"
  task :start do
    system "nohup bundle exec sidekiq >> #{Rails.root.join("log", "sidekiq.log")} 2>&1 &"
  end

  def pidfile
    Rails.root.join("tmp", "pids", "sidekiq.pid")
  end
end