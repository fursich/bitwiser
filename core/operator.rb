module Bitwiser
  module OperationHelper
    def operate_self(operator)
      self.class.new map(&operator.to_sym)
    end

    def operate_with(other, operator, filling: 0)
      new_sequence = zip_sequences(other).map do |first_bit, second_bit|
        first_bit  ||= Bit.new(filling)
        second_bit ||= Bit.new(filling)
        first_bit.send(operator, second_bit)
      end
      self.class.new new_sequence
    end

    def fill_left(fill_size, base_sequence: sequence, filling: 0)
      create_filling(fillsize, filling: filling) + base_sequence
    end

    def fill_right(fill_size, base_sequence: sequence, filling: 0)
      base_sequence + create_filling(fill_size, filling: filling)
    end

    def zip_sequences(other)
      sequence.zip(other.sequence)
    end
  end

  module NativeOperator
    OPERATORS = %i(and or xor)
    OPERATORS.each do |operator|
      define_method(operator) { |other| operate_with other, operator }
    end

    MONO_OPERATORS = %i(not)
    MONO_OPERATORS.each do |operator|
      define_method(operator) { operate_self operator }
    end
  end

  module LogicalOperator
    def rotate_left(n=1)
      self.class.new sequence.rotate(n)
    end
    alias_method :rol,    :rotate_left

    def rotate_right(n=1)
      self.class.new sequence.rotate(-n)
    end
    alias_method :ror, :rotate_right

    def logical_shift_left(n=1)
      self.class.new fill_right(n).slice(n..-1)
    end
    alias_method :lsl, :logical_shift_left

    def logical_shift_right(n=1)
      self.class.new fill_left(size + n).slice(0..n-1)
    end
    alias_method :lsr, :logical_shift_right
  end
end
