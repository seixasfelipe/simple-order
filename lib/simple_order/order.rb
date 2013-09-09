module SimpleOrder
  class Order
    attr_reader :date, :customer, :list_items

    def initialize(customer, date=Time.now)
      raise TypeError, "customer parameter must be an object of type Customer." \
        unless customer.is_a? Customer
      
      @customer   = customer
      @date       = date
      @list_items = ListItems.new
    end

    def add(item, qty=1)
      validates_item(item)

      @list_items.push item, qty
    end

    private

    def validates_item(item)
      raise ArgumentError, "An item must be a hash." \
        unless item.is_a? Hash
      raise ArgumentError, "An item must have a name." \
        unless item[:name] && item[:name].length > 0
      raise ArgumentError, "An item must have a price greater or equals to zero." \
        unless item[:price] && item[:price] >= 0
    end
  end
end