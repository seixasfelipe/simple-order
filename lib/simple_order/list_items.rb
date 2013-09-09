module SimpleOrder
  class ListItems
    include Enumerable

    def initialize
      @list_items = []
    end

    def push(item)
      @list_items << item
    end

    def length
      @list_items.length
    end

    def each(&block)
      @list_items.each(&block)
    end

    alias_method :<<, :push
    alias_method :size, :length

  end
end