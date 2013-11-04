require 'spec_helper'

module SimpleOrder
  module AR
    describe LineItem do

      subject(:line_item) { LineItem.new }
      subject(:item1) { Item.new({ name: "product 1", qty: 5, unit_price: 5.20 }) }
      subject(:item2) { Item.new({ name: "product 2", qty: 1, unit_price: 10.0 }) }
      subject(:item3) { Item.new({ name: "product 3", qty: 0, unit_price: 50.0 }) }

      it "should have a name" do
        line_item.name = nil
        expect(line_item).not_to be_valid
        expect(line_item.errors[:name]).to have(1).errors
      end

      it "should have at least one item" do
        expect(line_item).not_to be_valid
        expect(line_item.errors[:items]).to have(1).errors
      end

      it "should initialize total price with 0" do
        expect(line_item.total_price).to eq 0.0
      end

      it "should calculate total price when it has 1 item" do
        line_item.items << item1
        expect(line_item.total_price).to eq 26.0
      end

      it "should calculate total price when it has 2 items" do
        line_item.items << item1
        line_item.items << item2
        expect(line_item.total_price).to eq 36.0
      end
    end
  end
end
