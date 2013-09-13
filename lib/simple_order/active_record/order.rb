module SimpleOrder
  module AR
    class Order < ActiveRecord::Base
      validates_presence_of :date

      after_initialize :init

      def init
        self.date  ||= Time.now
      end

    end
  end
end