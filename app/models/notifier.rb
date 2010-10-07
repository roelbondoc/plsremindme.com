class Notifier < ActionMailer::Base
  def reminder(user)
    recipients user.email
    bcc        'admin@plsremindme.com'
    from       '\'PlsRemindMe\' <noreply@plsremindme.com>'
    subject    'Reminding you - PlsRemindMe.com'
    body       :user => user
  end
end
