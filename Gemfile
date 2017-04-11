source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'

#specify databases for our Development and Production environments (dev on line 12)
#heroku only supports Postgres so we use 'pg' in our prod environment
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
# we use sqlite3 for our dev environment because it is an easy database for rapid testing
group :development do
  gem 'sqlite3'
  gem 'pry-rails'
end

# Adds rspec to both the development and test groups
# We specified version ~> 3.0 to maintain predictable behavior despite new RSpec releases
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda'
  gem 'factory_girl_rails', '~> 4.0'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Used for encrypting User passwords
gem 'bcrypt'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'bootstrap-sass'

gem 'figaro', '1.0'
