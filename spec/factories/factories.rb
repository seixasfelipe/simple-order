FactoryGirl.define do
  factory :customer, class: 'SimpleOrder::AR::Customer' do
    name  'John Doe'
    email 'john@doe.com'
  end  
end