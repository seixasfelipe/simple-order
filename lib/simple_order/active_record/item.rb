module SimpleOrder
  module AR
    class Item < ActiveRecord::Base
      validates :name,  presence: true
      validates :qty,   numericality: { greater_than: 0, only_integer: true }
      validates :unit_price, numericality: { greater_than: 0 }
      validates :line_item, presence: true

      belongs_to :line_item

      after_initialize :default_values

      def total_price
        self.qty * self.unit_price
      end

      private

      def default_values
        self.qty ||= 0
        self.unit_price ||= 0.00
      end
    end
  end
end