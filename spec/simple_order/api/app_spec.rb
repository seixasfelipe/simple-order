require_relative '../api_spec_helper'

describe 'Customers Path' do
  describe 'GET /api/customers' do
    subject(:response_body) { JSON.parse(last_response.body)}
    
    before { get '/api/customers' }
 
    it 'is successful' do
      expect(last_response.status).to eq 200
    end

    it 'list all customers' do
      expect(response_body).to eq ({ "status"=>"success", "customers"=>[]})
    end
  end
end