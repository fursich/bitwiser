require_relative 'bit_operator.rb'

module Bitwiser
  class Bit
    include BitOperator

    BOOL_VALUES = {
      1 => true,
      0 => false,
    }

    def initialize(initial_value=0, carry: false, borrow: false)
      @bool_value = self.class.to_bool initial_value
      @carry      = carry
      @borrow     = borrow
    end

    def value
      self.class.to_value(bool_value)
    end
    alias_method :to_i, :value

    def to_str
      value.to_s
    end
    alias_method :to_s, :to_str

    def to_bool
      bool_value
    end

    def carry?
      !!carry
    end

    def borrow?
      !!borrow
    end

    def flag_states
      {
        carry: carry?,
        borrow: borrow?,
      }
    end

    class << self
      def to_value(bool_value)
        BOOL_VALUES.invert[bool_value]
      end

      def to_bool(value)
        bool_value = BOOL_VALUES[value]
        raise InvalidBitValue if bool_value.nil?
        bool_value
      end

      def build_with_bool(bool_value, carry: false, borrow: false)
        new to_value(bool_value), carry: carry, borrow: borrow
      end
    end

    private

    attr_reader :bool_value, :carry, :borrow

    def carry!
      @carry  = true
      @borrow = false
    end

    def borrow!
      @carry  = false
      @borrow = true
    end
  end
end
