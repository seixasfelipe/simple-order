require 'spec_helper'

module SimpleOrder
  module AR
    describe Customer do

      subject(:customer) { Customer.new }

      it "should have a name" do
        customer.name = nil
        expect(customer).not_to be_valid
        expect(customer.errors[:name]).to have(1).errors
      end

      it "should have an email" do
        customer.email = nil
        expect(customer).not_to be_valid
        expect(customer.errors[:email]).to have(1).errors
      end

    end
  end
end