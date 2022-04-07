require_relative "environment"
env :PATH, ENV['PATH']
set :environment, Rails.env
set :output, "log/cron_job.log"

every Settings.one.day, at: Settings.hour_execute do
  rake "admin:create_book_everyday"
end

