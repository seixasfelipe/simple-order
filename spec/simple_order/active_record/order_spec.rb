require 'spec_helper'

module SimpleOrder
  module AR
    describe Order do

      subject(:customer) { Customer.new }
      subject(:order) { Order.new }

      it "should have a date" do
        order.date = nil
        expect(order).not_to be_valid
        expect(order.errors[:date]).to have(1).errors
      end

      it "should have current date when initialized" do
        time = Time.parse('2013-09-13 10:33:59')
        Time.stub now: time

        order.customer = customer

        expect(order).to be_valid
        expect(order).to have(:no).errors
        expect(order.date).to be_eql(time)
      end

      it "should belongs to a customer" do
        order.customer = nil
        expect(order).not_to be_valid
        expect(order.errors[:customer]).to have(1).errors
      end
    end
  end
end