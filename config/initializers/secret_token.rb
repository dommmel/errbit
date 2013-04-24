# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# Everyone can share the same token for development/test
if %w(development test).include? Rails.env
  Errbit::Application.config.secret_token = '0e2842261c80dd758ff80c4f931dd496b09b87636f3df99a4b0f3758347426dfa5f42a2537549837b870cfc4a8594792da6dc03a6bb969553926c723f887ea65'
else

  if ENV['SECRET_TOKEN'].present?
    Errbit::Application.config.secret_token = ENV['SECRET_TOKEN']

  # Do not raise an error if secret token is not available during assets precompilation
  elsif ENV['RAILS_GROUPS'] != 'assets'
    raise <<-ERROR

  You must generate a unique secret token for your Errbit instance.

  If you are deploying via capistrano, please ensure that your `config/deploy.rb` contains
  the new `errbit:setup_configs` and `errbit:symlink_configs` tasks from `config/deploy.example.rb`.
  Next time you deploy, your secret token will be automatically generated.

  If you are deploying to Heroku, please run the following command to set your secret token:
      heroku config:add SECRET_TOKEN="$(bundle exec rake secret)"

  If you are deploying in some other way, please run the following command to generate a new secret token,
  and commit the new `config/initializers/secret_token.rb`:

      echo "Errbit::Application.config.secret_token = '$(bundle exec rake secret)'" > config/initializers/secret_token.rb

  ERROR
  end
end

