source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.5'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8', '>= 7.0.8.4'

gem 'active_storage_validations', '0.9.8'
gem 'ancestry'
gem 'bcrypt', '3.1.18'
gem 'bootsnap', '1.16.0', require: false
gem 'faker', '2.21.0'
gem 'hashid-rails', '~> 1.0'
gem 'image_processing', '1.12.2'
gem 'importmap-rails', '1.1.5'
gem 'jbuilder', '2.11.5'
gem 'mysql2'
gem 'puma', '~> 6.0'
gem 'sassc-rails', '>= 2.1.0'
gem 'sprockets-rails', '3.4.2'
gem 'sqlite3', '1.6.1'
gem 'stimulus-rails', '1.2.1'
gem 'turbo-rails', '1.4.0'
gem 'will_paginate', '3.3.1'

group :development, :test do
  gem 'debug', '1.7.1', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano3-puma', '6.0.0.beta.1', require: false
  gem 'capistrano3-unicorn', require: false # 必要に応じて
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'irb', '1.10.0'
  gem 'repl_type_completor', '0.1.2'
  gem 'solargraph', '0.50.0'
  gem 'web-console', '4.2.0'
end

group :test do
  gem 'capybara',                 '3.38.0'
  gem 'guard',                    '2.18.0'
  gem 'guard-minitest',           '2.4.6'
  gem 'minitest',                 '5.18.0'
  gem 'minitest-reporters',       '1.6.0'
  gem 'rails-controller-testing', '1.0.5'
  gem 'selenium-webdriver',       '4.8.3'
  gem 'webdrivers',               '5.2.0'
end
