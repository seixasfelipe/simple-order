module SimpleOrder
  module AR
    class LineItem < ActiveRecord::Base
      validates :name, presence: true
      validates :items, length: { minimum: 1 }

      has_many :items

      after_initialize :default_values

      def total_price
        self.items.inject(0) do |s, i|
          s + i.total_price
        end
      end

      private

      def default_values
        self.total_price ||= 0.0
      end
    end
  end
end