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
    end
  end
end