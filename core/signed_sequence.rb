require_relative 'bit_sequence.rb'

module Bitwiser
  class SignedSequence < BitSequence::Base

    attr_reader :sign_bit

    def initialize(value, size=nil)
      super(value, size)
      @sign_bit = sequence.first
    end

    def negative?
      !@sign_bit.value.zero?
    end

    def to_i
      positive? ? to_integer(sequence) : - to_integer(self.not.sequence) - 1
    end

    private

    def cast_integer(value) # >= 2 bits at minimum (incl. 0, 1, -1)
      casted_value    = value.negative? ? -(value+1) : value
      binary_exp      = '0' + casted_value.to_s(2)
      value.negative? ? negate_binary_exp(binary_exp) : binary_exp
    end

    def negate_binary_exp(str)
      str.tr('01', '10')
    end

    def filling_for(value)
      cast(value).slice(0).to_i
    end
  end
end
