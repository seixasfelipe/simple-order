module SimpleOrder
  class Order
    attr_reader :date, :customer, :list_items

    def initialize(customer, date=Time.now)
      raise TypeError, "customer parameter must be an object of type Customer" \
        unless customer.is_a? Customer
      
      @customer   = customer
      @date       = date
      @list_items = []
    end

    def add(item)
      @list_items << item
    end
  end
end