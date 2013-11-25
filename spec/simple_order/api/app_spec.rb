require_relative '../api_spec_helper'

describe 'Customers Path' do
  describe 'GET /api/customers' do
    subject(:response_body) { JSON.parse(last_response.body)}

    let!(:customers) {[
      FactoryGirl.create(:customer, name: 'John', email: 'john@doe.com'),
      FactoryGirl.create(:customer, name: 'Mark', email: 'mark@doe.com')
    ]}
    
    before { get '/api/customers' }
 
    it 'is successful' do
      expect(last_response.status).to eq 200
    end

    it 'list all customers' do
      expect(response_body).to eq ({ 
        "status"=>"success", 
        "customers"=> customers.map { |c| { 
          "id"    => c.id, 
          "name"  => c.name, 
          "email" => c.email } 
        }
      })
    end
  end
end