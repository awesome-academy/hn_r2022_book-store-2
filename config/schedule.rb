require_relative "environment"
env :PATH, ENV['PATH']
set :environment, Rails.env
set :output, "log/cron_job.log"

every 1.minute do
  rake "admin:create_book_everyday"
end

