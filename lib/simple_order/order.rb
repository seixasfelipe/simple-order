module SimpleOrder
  class Order
    attr_reader :date

    def initialize
      @date = Time.now
    end
  end
end