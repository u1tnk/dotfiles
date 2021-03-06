#
# Rails Application Template
#

gems = {}

# gems
# ==================================================
gem_group :test, :development do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
  gem 'awesome_print'
  gem 'tapp'
end

gem_group :test do
  gem 'faker'
  gem 'capybara'
  gem 'database_rewinder'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec-parameterized'
  gem 'timecop'
end

gem_group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'xray-rails'

  gem 'capistrano-bundler', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano3-unicorn', require: false

  gem 'rails-erd'
end

gem 'rails_config'
uncomment_lines 'Gemfile', "gem 'unicorn'"
comment_lines 'Gemfile', "gem 'sqlite3'"
gem 'execjs'
uncomment_lines 'Gemfile', "gem 'therubyracer'"
uncomment_lines 'Gemfile', "gem 'capistrano-rails'"
uncomment_lines 'Gemfile', "gem 'bcrypt'"

if yes?('use carrierwave ?')
  gem 'carrierwave'
end

if yes?('use rmagick ?')
  gem 'rmagick', :require => false
end

gems['whenever'] = yes?('use whenever?')
if gems['whenever']
  gem 'whenever'
end

if yes?('use nokogiri?')
  gem 'nokogiri'
end

if yes?('use sass/compass?')
  gem 'compass-rails'
end

gem 'kaminari'
gem 'logger-ltsv'
gem 'mysql2'

run 'bundle install -j5 --path=vendor/bundle'

# generate base_controller
# ==================================================
generate(:controller, 'api::application')

# install spec_helper.rb
# ==================================================
generate 'rspec:install'
run 'rm -rf test'

# add rails_config
# ==================================================
generate('rails_config:install')
rails_config = <<-CODE
s3:
  bucket: <bucket>
  endpoint_url: <s3url>
CODE

file 'config/settings.yml', rails_config

# setting whenever
# ==================================================
if gems['whenever']
  run 'bundle exec wheneverize'
end

# setting .gitignore
# ==================================================
gitignore = <<-CODE
db/schema.rb
vendor/bundle
CODE

File.open('.gitignore', 'a') do |file|
  file.write gitignore
end

