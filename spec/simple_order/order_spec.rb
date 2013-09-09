require 'spec_helper'

module SimpleOrder
  describe Order do

    it "should have a date" do
      time = Time.parse('2013-09-08 10:33:59')
      Time.stub now: time

      order = Order.new
      order.date.should be_eql time
    end

  end
end