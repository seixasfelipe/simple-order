require 'spec_helper'

module SimpleOrder
  describe ListItems do

    let(:list_items) { ListItems.new }
    let(:item) { { name: "item 1" } }
    let(:another_item) { { name: "item 2" } }

    describe "#adding one item" do    
      it "using push method" do
        list_items.push item
        validates_addition_of item, 1
      end

      it "using << method" do
        list_items << item
        validates_addition_of item, 1
      end

      it "using add method" do
        list_items.add item
        validates_addition_of item, 1
      end
    end

    describe "#adding one item twice" do
      it "using add twice" do
        list_items.add item
        list_items.add item
        validates_addition_of item, 2
      end

      it "using add once" do
        list_items.add item, 2
        validates_addition_of item, 2
      end
    end

    describe "#adding one item three times" do
      it "using add once and twice after" do
        list_items.add item
        list_items.add item, 2
        validates_addition_of item, 3
      end
    end

    it "should allow add two different items" do
      list_items.add item
      list_items.add another_item

      list_items.should have_exactly(2).item
      list_items.first.should be_eql({ item: item, qty: 1})
      list_items[-1].should be_eql({ item: another_item, qty: 1})
    end

    private

    def validates_addition_of(item, qty)
      list_items.should have_exactly(1).item
      list_items.first.should be_eql({ item: item, qty: qty})
    end
  end
end