require 'spec_helper'

require 'rack/test'

$:.unshift File.expand_path("../../../app", __FILE__)
require 'app'

RSpec.configure do |config|
  include Rack::Test::Methods
 
  def app
    SimpleOrder::Api::Base
  end
end