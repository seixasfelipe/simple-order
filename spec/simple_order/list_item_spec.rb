require 'spec_helper'

module SimpleOrder
  describe ListItems do

    let(:item) { { name: "item 1" } }
    
    it "should add an item" do
      list_items = ListItems.new
      list_items << item
      
      list_items.should have_exactly(1).item
      list_items.first.should be_eql item
    end

  end
end