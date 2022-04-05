Devise.setup do |config|
  config.mailer_sender = "admin@bookstore.com"

  require "devise/orm/active_record"

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.reset_password_within = 6.hours

  config.scoped_views = true

  OmniAuth.config.allowed_request_methods = [:post, :get]
  OmniAuth.config.silence_get_warning = true

  config.omniauth :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    scope: "userinfo.profile,userinfo.email",
    access_type: "offline",
    approval_prompt: "force"
  }
end
