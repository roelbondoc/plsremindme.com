task :cron => :environment do
  User.get_all_reminders
end
