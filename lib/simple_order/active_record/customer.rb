module SimpleOrder
  module AR
    class Customer < ActiveRecord::Base
      validates_presence_of :name, :email
    end
  end
end