module SimpleOrder
  class ListItems
    include Enumerable

    def initialize
      @list_items = []
    end

    def push(item, qty=1)
      pushed = false
      self.each { |h|
        h[:qty] += qty if h[:item] == item
        pushed = true
      }
      
      @list_items << { item: item, qty: qty } unless pushed
    end

    def length
      @list_items.length
    end

    def each(&block)
      @list_items.each(&block)
    end

    alias_method :<<  , :push
    alias_method :add , :push
    alias_method :size, :length

  end
end