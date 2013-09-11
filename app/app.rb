require 'sinatra'
require 'json'

set :root, Dir.pwd

set :public_folder, File.join(settings.root, 'app/public')
set :views, File.join(settings.root, 'app/views')

set :haml, format: :html5, layout: :application


get '/' do
  haml :'order/new'
end

get '/new' do
  haml :'order/new'
end

get '/invoice' do
  haml :'order/invoice'
end

get '/order' do
  order = {
    id: 'SO030PD',
    date: Time.now, 
    from: {
      name: 'Simple Inc.',
      email: 'info@simpleinc.com',
      address: {
        street: '100 Av. du Parc',
        city: 'Montreal',
        zipcode: 'HVM 7R4',
        country: 'Canada'
      }
    },
    to: {
      id: 'CU2304',
      name: 'Foo Bar',
      email: 'foo@bar.com',
      address: {
        street: '1450 Boul. Rene-Levesque',
        city: 'Montreal',
        zipcode: 'HWA ND8',
        country: 'Canada'
      }
    },
    items: [
      { id: 'SO1234', description: 'Shampooing moteur', unit_price: 39.95, qty: 1, total_price: 39.95 },
      { id: 'SO4930', description: 'Cirage professionnel', unit_price: 79.95, qty: 1, total_price: 79.95 },
      { id: 'SO9237', description: 'Vitres teintees 4 portes', unit_price: 262.95, qty: 1, total_price: 262.95 }
    ],
    status: 'open',
    taxes: [
      { name: 'tps', value: 19.14 },
      { name: 'tvq', value: 38.18 }
    ],
    subtotal: 382.85,
    total: 440.17
  }
  
  [200, { 'Content-Type' => 'application/json' }, [order.to_json] ]
end