Rails.application.config.action_mailer.smtp_settings = {
  address: ENV['MAILGUN_SMTP_SERVER'] || 'smtp.mailgun.org',
  port: ENV['MAILGUN_SMTP_PORT'] || 587,
  domain: ENV['MAILGUN_DOMAIN'],
  user_name: ENV['MAILGUN_SMTP_LOGIN'],
  password: ENV['MAILGUN_SMTP_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}
