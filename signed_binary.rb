require_relative 'core/bit_sequence.rb'

module Bitwiser
  class Signed < BitSequence::Base
    attr_reader :msb

    def initialize(value, size=nil)
      super(value, size)
      msb = sequence.first
    end

    def sign
      msb.to_bool ? :- : :+
    end

    def plus?
      !minus?
    end

    def minus?
      @msb.to_bool
    end

    def to_i
      plus? ? to_integer(sequence) : to_integer(self.not.sequence) + 1
    end

    private

    def cast_integer(value)
      return '1' if value == -1

      casted_value    = value.negative? ? -(value+1) : value
      binary_exp      = '0' + casted_value.to_s(2)
      value.negative? ? negate_binary_exp(binary_exp) : binary_exp
    end

    def negate_binary_exp(str)
      str.tr('01', '10')
    end

    def filling_for(value)
      value.negative? ? 1 : 0
    end
  end
end
