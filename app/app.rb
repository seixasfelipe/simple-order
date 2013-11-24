ENV['RACK_ENV'] ||= 'development'
 
require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/base'
require 'sinatra/namespace'
require 'json'

$:.unshift File.expand_path("../../lib", __FILE__)
require 'simple_order'

module Rack
  class JsonResponse
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      contentType = headers['Content-Type']
      
      # Converts response body to json format
      if contentType && contentType =~ /application\/json/
        body = [body.to_json]
      end

      [status, headers, body]
    end
  end
end


module SimpleOrder::Api
  class Base < ::Sinatra::Base

    register Sinatra::ActiveRecordExtension

    configure do
      set :root, Dir.pwd

      set :public_folder, File.join(settings.root, 'app/public')
      set :views, File.join(settings.root, 'app/views')
      set :haml, format: :html5, layout: :application

      set :database_file, 'db/database.yml'

      use Rack::Session::Pool
      use Rack::Lint
      use Rack::JsonResponse

      # Register plugins
      register ::Sinatra::Namespace

    end

    namespace '/api' do

      # Set default content type to json
      before do
        content_type :json
      end

      get '/customers' do
        customers = SimpleOrder::AR::Customer.all.map { |c| { id: c.id, name: c.name, email: c.email } }
        { status: "success", customers: customers }
      end
    end

    get '/' do
      redirect to('/new')
    end

    get '/new' do
      haml :'order/new'
    end

    post '/create' do
      puts params
      customer  = SimpleOrder::Basic::Customer.new(params['customer:name'], params['customer:email'])
      order     = SimpleOrder::Basic::Order.new(customer)

      add_order order

      redirect to('/new')
    end

    get '/invoice' do
      haml :'order/invoice'
    end

    get '/order', provides: 'json' do
      fake_order
    end

    get '/order/:id', provides: 'json' do
      order = get_order params[:id].to_i
      order.to_h
    end

    def add_order(order)
      session[:orders] = [] unless session[:orders]
      session[:orders].push order
      order
    end

    def get_order(id)
      return fake_order if id <= 0
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
  end
end
