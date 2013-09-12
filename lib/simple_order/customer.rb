module SimpleOrder
  class Customer

    attr_reader :name, :email

    def initialize(name, email)
      @name   = name
      @email  = email
    end

    def to_h
      {
        name: @name,
        email: @email
      }
    end
  end
end