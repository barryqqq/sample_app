# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
#SampleApp::Application.config.secret_key_base = 'c7eaa02af6583416bf8171f77c4a4a3053b40486060813c5211a680dde18603399b319dd0428ff2a5e4980a7898d3e34b5740f89cb97fd118ebb01ee58b314ff'
SampleApp::Application.config.secret_key_base = ENV['SECRET_TOKEN']