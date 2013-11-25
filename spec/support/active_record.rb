# require 'active_record'
# require 'logger'
require 'factory_girl'
require 'database_cleaner'

# ActiveRecord::Base.logger = Logger.new('log/test.db.log')
# ActiveRecord::Base.logger.level = 2
# dbconfig = YAML.load(File.read("db/database.yml"))[ENV['RACK_ENV']]
# ActiveRecord::Base.establish_connection dbconfig

FactoryGirl.find_definitions