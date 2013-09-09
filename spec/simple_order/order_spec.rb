require 'spec_helper'

module SimpleOrder
  describe Order do

    let(:customer) { Customer.new("foo", "foo@bar.com" ) }
    let(:order) { Order.new(customer) }
    let(:item) { { name: "item 1", price: 10.50 } }
    let(:another_item) { { name: "item 2", price: 5.00 } }

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

      it "should have an empty list of items" do
        order.list_items.should be_a_kind_of ListItems
        order.list_items.should have_exactly(0).items
      end

    end

    describe "#adding items ->" do

      it "should add an item" do
        order.add item
        order.list_items.should have_exactly(1).item
        order.list_items.first[:item].should be_eql item
      end

      it "should not add an item without name" do
        item = { price: 10.50 }
        expect { order.add item }.to raise_error(ArgumentError, "An item must have a name.")
      end

      it "should not add an item with empty name" do
        item = { name: "" }
        expect { order.add item }.to raise_error(ArgumentError, "An item must have a name.")
      end

      it "should not add an item without price" do
        item = { name: "item 1" }
        expect { order.add item }.to raise_error(ArgumentError, "An item must have a price greater or equals to zero.")
      end

      it "should not add an item with negative price" do
        item = { name: "item 1", price: -0.1}
        expect { order.add item }.to raise_error(ArgumentError, "An item must have a price greater or equals to zero.")
      end

      it "should allow price equals to 0" do
        item = { name: "item 1", price: 0}
        expect { order.add item }.not_to raise_error
      end

      it "should add only hash items" do
        item = "this is an item"
        expect { order.add item }.to raise_error(ArgumentError, "An item must be a hash.")
      end

      it "should add an item twice" do
        order.add item, 2
        order.list_items.should have_exactly(1).item
        order.list_items.first.should be_eql({ item: item, qty: 2, total_price: (item[:price] * 2)})
      end

    end

    describe "#order total -> " do

      it "subtotal should be the sum of an item" do
        order.add item
        order.subtotal.should be_eql 10.50
      end

      it "subtotal should be the sum of two different items" do
        order.add item
        order.add another_item
        order.subtotal.should be_eql 15.50
      end

      it "subtotal should be the sum of one item that was added twice" do
        order.add item, 2
        order.subtotal.should be_eql 21.00
      end

    end

  end
end