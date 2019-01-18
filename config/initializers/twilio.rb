Twilio.configure do |config|
  config.account_sid = 'ACb2ad07724169ab5a936792cab72db14c'
  config.auth_token = 'c36f5a2288b4ff5bacce781ed0519d2f'
  $client = Twilio::REST::Client.new(config.account_sid, config.auth_token)
end