require 'spec_helper'

module SimpleOrder
  module AR
    describe Order do

      subject(:customer) { Customer.new }
      subject(:order) { Order.new }
      subject(:line_item_products) { 
        li = LineItem.new()
        li.name = "products"
        li.items << Item.new({ name: "product 1", qty: 2, unit_price: 10, line_item: li })
        li.items << Item.new({ name: "product 2", qty: 5, unit_price: 5, line_item: li })
        li
      }
      subject(:line_item_taxes) {
        li = LineItem.new({ name: "taxes" })
      }

      it "should have a date" do
        order.date = nil
        expect(order).not_to be_valid
        expect(order.errors[:date]).to have(1).errors
      end

      it "should have current date when initialized" do
        time = Time.parse('2013-09-13 10:33:59')
        Time.stub now: time

        order.customer = customer
        order.line_items << line_item_products

        expect(order).to be_valid
        expect(order).to have(:no).errors
        expect(order.date).to be_eql(time)
      end

      it "should belongs to a customer" do
        order.customer = nil
        expect(order).not_to be_valid
        expect(order.errors[:customer]).to have(1).errors
      end

      it "should have a collection of line items" do
        expect(order.line_items).to have(:no).items
      end

      it "should have at least one line item" do
        expect(order).not_to be_valid
        expect(order.errors[:line_items]).to have(1).errors
      end

      it "should calculate subtotal price" do
        order.line_items << line_item_products
        expect(order.subtotal).to eq(45.0)
      end

      it "should calculate including two taxes" do
        order.line_items << line_item_products

        line_item_taxes.items << Item.new({ name: "GST", qty: 1, unit_price: 5, line_item: line_item_taxes })
        line_item_taxes.items << Item.new({ name: "QST", qty: 1, unit_price: 9.975, line_item: line_item_taxes })
        order.line_items << line_item_taxes
        
        expect(order.subtotal).to be_eql(45.0)
        expect(order.total).to eq(45.0 + 6.74)
      end
    end
  end
end