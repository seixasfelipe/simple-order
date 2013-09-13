module SimpleOrder
  module Basic
    class ListItems
      include Enumerable

      def initialize
        @list_items = []
      end

      def push(item, qty=1)
        pushed = false
        self.each { |h|
          if h[:item] == item
            h[:qty] += qty
            h[:total_price] += (item[:price] * qty)
            pushed = true
          end
        }
        
        @list_items << { item: item, qty: qty, total_price: (item[:price] * qty) } unless pushed
      end

      def length
        @list_items.length
      end

      def each(&block)
        @list_items.each(&block)
      end

      def [](val)
        @list_items[val]
      end

      def to_a
        @list_items
      end

      alias_method :<<  , :push
      alias_method :add , :push
      alias_method :size, :length

    end
  end
end