require 'sinatra'
require 'json'

$:.unshift File.expand_path("../../lib", __FILE__)
require 'simple_order'


configure do
  set :root, Dir.pwd

  set :public_folder, File.join(settings.root, 'app/public')
  set :views, File.join(settings.root, 'app/views')

  set :haml, format: :html5, layout: :application

  use Rack::Session::Pool
end

get '/' do
  redirect to('/new')
end

get '/new' do
  haml :'order/new'
end

post '/create' do
  puts params
  customer  = SimpleOrder::Customer.new(params['customer:name'], params['customer:email'])
  order     = SimpleOrder::Order.new(customer)

  add_order order

  redirect to('/new')
end

get '/invoice' do
  haml :'order/invoice'
end

get '/order/:id' do
  content_type :json
  
  order = get_order params[:id].to_i
  order.to_h.to_json
end

def add_order(order)
  session[:orders] = [] unless session[:orders]
  session[:orders].push order
  order
end

def get_order(id)
  orders = session[:orders]
  return nil unless orders
  return nil if orders && id > orders.size
  orders[id - 1]
end

def fake_order
  {
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
end
