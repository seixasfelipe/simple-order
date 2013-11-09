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
        self.line_items.inject(0) do |s, i|
          s + i.total_price
        end
      end
    end
  end
end