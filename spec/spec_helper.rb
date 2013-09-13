ENV['RACK_ENV']='test'

require 'simple_order'

$:.unshift File.expand_path("../../app", __FILE__)
require 'app'