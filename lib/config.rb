require "yaml"

file = YAML.load_file("#{File.expand_path File.dirname(__FILE__)}/config.yml")

Twitter.configure do |config|
  config.consumer_key       = file["twitter"]["consumer_key"]
  config.consumer_secret    = file["twitter"]["consumer_secret"]
  config.oauth_token        = file["twitter"]["oauth_token"]
  config.oauth_token_secret = file["twitter"]["oauth_token_secret"]
end

Bitly.use_api_version_3
B = Bitly.new(file["bitly"]["username"], file["bitly"]["password"])

