source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'

gem 'thin'
gem 'haml' # remove later when using only API (json responses)
gem 'activerecord'
gem 'sinatra-activerecord'

group :test do
  gem 'rspec',            '~> 2.14'
  gem 'factory_girl',     '~> 4.3' 
  gem 'database_cleaner', '~> 1.2.0'
  gem 'rack-test'
end

group :development do
  gem 'rerun',        '~> 0.8.2'
  gem 'rb-fsevent',   '~> 0.9.3'
end

group :development, :test do
  gem 'sqlite3'
end