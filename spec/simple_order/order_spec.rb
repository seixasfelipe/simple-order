require 'spec_helper'

module SimpleOrder
  describe Order do

    let(:customer) { Customer.new("foo", "foo@bar.com" ) }
    let(:order) { Order.new(customer) }

    describe "#basic creation ->" do

      it "should have a date" do
        time = Time.parse('2013-09-08 10:33:59')
        Time.stub now: time

        order.date.should be_eql time
      end

      it "shoud have a specfic date" do
        time = Time.parse('2013-01-08 12:12:59')

        order = Order.new customer, time
        order.date.should be_eql time
      end

      it "should have a customer" do 
        order.customer.should be_eql customer
      end

      it "should raise ArgumentError when order has invalid customer" do
        c = { name: "foo bar" }
        expect { Order.new(c) }.to raise_error(TypeError)
      end

    end

    describe "#adding items ->" do

      let(:item) { { name: "item 1", unit_price: 10.50 } }

      it "should add an item" do
        order.add item
        order.list_items.should have_exactly(1).item
        order.list_items.first.item.should be_eql Item.new(item)
      end

      it "should add two items"
      it "should add an item twice"

    end

  end
end