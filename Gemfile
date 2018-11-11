# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'elasticsearch-persistence', '6.0.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'
gem 'rspec-rails', '3.8.1'
gem 'virtus', '1.0.5'

group :development, :test do
  gem 'dotenv-rails', '2.5.0'
  gem 'pry', '0.12.0'
end

group :development do
  gem 'guard-rspec', '4.7.3'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '0.60.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
