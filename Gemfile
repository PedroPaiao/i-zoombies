source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Server gems
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Utils gems
# Allows you to generate your JSON in an object-oriented and convention-driven manner
gem 'active_model_serializers', '~> 0.10.12'
# Kaminari is a Scope & Engine based, clean, powerful, agnostic, customizable and sophisticated paginator for Rails 4+
gem 'kaminari', '~> 1.2', '>= 1.2.1'
# Enumerated attributes with I18n and ActiveRecord/Mongoid/MongoMapper support
gem 'enumerize', '~> 2.4'

# Pattern gems
# General purpose service object abstraction
gem 'business_process', '~> 1.0', '>= 1.0.3'
# New wave Internationalization support for Ruby.
gem 'i18n', '~> 1.8', '>= 1.8.10'
# RuboCop is a Ruby code style checking and code formatting tool. It aims to enforce the community-driven Ruby Style Guide.
gem 'rubocop', '~> 1.21'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # spec-rails is a testing framework for Rails 5+.
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2'
  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer
  gem 'factory_bot_rails', '~> 6.2'
  # Strategies for cleaning databases using ActiveRecord. Can be used to ensure a clean state for testing.
  gem 'database_cleaner-active_record', '~> 2.0', '>= 2.0.1'
end

# Development helpers
group :development do
  # The Listen gem listens to file modifications and notifies you about the changes. Works everywhere!
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Tests Helper
group :test do
 # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
  gem 'faker', '~> 2.15', '>= 2.15.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
