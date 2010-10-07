class Validator < ActionMailer::Base
  def email_validation(user)
    recipients user.email
    bcc        'admin@plsremindme.com'
    from       '\'PlsRemindMe\' <noreply@plsremindme.com>'
    subject    'PlsRemindMe.com - Email Validation'
    body       :user => user
  end
end
