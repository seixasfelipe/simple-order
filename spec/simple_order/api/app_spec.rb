require_relative '../api_spec_helper'

describe 'Root Path' do
  describe 'GET /' do
    before { get '/' }
 
    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
end