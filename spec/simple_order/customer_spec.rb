require 'spec_helper'

module SimpleOrder
  describe Customer do

    let(:customer) { Customer.new("foo", "foo@bar.com") }

    it "should have a name" do
      customer.name.should be_eql "foo"
    end

    it "should have an email" do
      customer.email.should be_eql "foo@bar.com"
    end

    it "should have a valid name"
    it "should have a valid email"
  end
end