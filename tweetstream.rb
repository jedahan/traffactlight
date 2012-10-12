require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = 'FY2uImX2wkYulhag7MbYw'
  config.consumer_secret    = 'DEa586Mjs21vqVXwc3sXN8Whu2EGb8WDD91Myk'
  config.oauth_token        = '14417425-oXfdcsFw2h8t90aW2tACD51m20ESOgpLTwDfK7gM1'
  config.oauth_token_secret = 'yrXcYoswRlPY4PtubVYMdPq5W7KrZveKJj12RNUH0'
  config.auth_method        = :oauth
end

# Use 'follow' to follow a group of user ids (integers, not screen names)
TweetStream::Client.new.follow(874569288) do |status|
  puts "#{status.text}"
end