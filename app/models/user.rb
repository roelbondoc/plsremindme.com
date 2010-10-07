class User < TwitterAuth::GenericUser
  has_many :reminders

  validates_uniqueness_of :email, :allow_nil => true, :allow_blank => true, :message => "That email address is already in use."
  validates_presence_of :email, :on => :update

  def self.get_all_reminders
    User.all.each do |user|
      user.get_reminders
      user.reload
      user.send_reminder
    end
  end

  def before_update
    if !self.email_valid || self.email_changed?
      self.email_validation_token = (0...3).map{ (('a'..'z').to_a | ('A'..'Z').to_a)[rand(52)] }.join + 
                                    (0...3).map{ (0..9).to_a[rand(10)] }.join
      self.email_valid = false
    end
    return true
  end

  def after_update
    Validator.deliver_email_validation(self) unless self.email_valid?
  end

  def scan_statuses
    statuses = self.twitter.get("/statuses/user_timeline.json")

    statuses.each do |status|
      self.reminders.create(:status_id => status['id'], :text => status['text'], :tweet => status) if status['text'].match(/@plsremindme/i)
    end
  end

  def scan_messages
    messages = self.twitter.get("/direct_messages/sent.json")

    messages.each do |message|
      self.reminders.create(:message_id => message['id'], :text => message['text'], :tweet => message) if message['recipient_id'] == 176869155
    end
  end

  def get_reminders
    begin
      self.scan_statuses
      self.scan_messages
    rescue
      logger.warn "No longer authorized by #{self.login}"
    end
  end

  def send_reminder
    Time.zone = self.time_zone
    begin
      Notifier.deliver_reminder(self) if self.email_valid? && (Time.zone.now.hour == 8 || Time.zone.now.hour == 20) && self.reminders.not_completed.count > 0
    rescue
      logger.warn "No longer authorized by #{self.login}"
    ensure
      Time.zone = ''
    end
  end
end
