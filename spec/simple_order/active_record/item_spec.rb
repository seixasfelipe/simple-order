require 'spec_helper'

module SimpleOrder
  module AR
    describe Item do

      # subject(:line_item) { LineItem.new }
      subject(:item) { Item.new }

      it "should have a name" do
        item.name = nil
        expect(item).not_to be_valid
        expect(item.errors[:name]).to have(1).errors
      end

      it "should have qty equals 0" do
        expect(item.qty).to eq 0
      end

      it "should have qty as number" do
        item.qty = 'word'
        expect(item).not_to be_valid
        expect(item.errors[:qty]).to have(1).errors
      end

      it "should have qty as integer" do
        item.qty = 10.5
        expect(item).not_to be_valid
        expect(item.errors[:qty]).to have(1).errors
      end

      it "should have qty greater than zero" do
        item.qty = -1
        expect(item).not_to be_valid
        expect(item.errors[:qty]).to have(1).errors

        item.qty = 0
        expect(item).not_to be_valid
        expect(item.errors[:qty]).to have(1).errors        
      end

      it "should have unit price equals 0" do
        expect(item.unit_price).to eq 0
      end

      it "should have unit price as number" do
        item.unit_price = 'word'
        expect(item).not_to be_valid
        expect(item.errors[:unit_price]).to have(1).errors
      end

      it "should have unit price greater than zero" do
        item.unit_price = -1
        expect(item).not_to be_valid
        expect(item.errors[:unit_price]).to have(1).errors

        item.unit_price = 0
        expect(item).not_to be_valid
        expect(item.errors[:unit_price]).to have(1).errors  
      end

      it "should belongs to a line item" do
        item.line_item = nil
        expect(item).not_to be_valid
        expect(item.errors[:line_item]).to have(1).errors
      end

    end
  end
end
