module SimpleOrder
  module AR
    class Order < ActiveRecord::Base
      validates_presence_of :date, :customer
      validates :line_items, length: { minimum: 1 }

      belongs_to :customer
      has_many :line_items

      after_initialize :default_values

      def default_values
        self.date  ||= Time.now
      end

      def subtotal
        self.line_items.inject(0.0) do |s, i|
          return s + i.total_price if i.name == "products"
          s
        end
      end

      def total
        (self.subtotal * (1 + total_taxes)).round(2)
      end

      private

      def total_taxes
        self.line_items.inject(0.0) do |s, i|
          return s + (i.total_price / 100) if i.name == "taxes"
          s
        end
      end
    end
  end
end