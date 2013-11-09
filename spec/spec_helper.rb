ENV['RACK_ENV'] = 'test'

require 'simple_order'

dbconfig = YAML.load(File.read("db/database.yml"))
ActiveRecord::Base.establish_connection dbconfig[ENV['RACK_ENV']]
