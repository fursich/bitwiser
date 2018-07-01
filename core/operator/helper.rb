module Bitwiser
  module Operator
    module Helper
      def operate_self(operator)
        self.class.new map(&operator.to_sym)
      end

      def operate_with(other, operator)
        operate_each_byte_with(other) { |first_bit, second_bit|
          first_bit.send(operator, second_bit)
        }
      end

      def fill_left(fill_size, base_sequence: sequence, filling: 0)
        create_filling(fill_size, filling: filling) + base_sequence
      end

      def fill_right(fill_size, base_sequence: sequence, filling: 0)
        base_sequence + create_filling(fill_size, filling: filling)
      end

      def operate_each_byte_with(other, &operator)
        raise InvalidOperandType.new 'mismatching types. check types of the receiver and its operand' unless type_of? other
        raise InvalidOperation.new 'no operator given' unless block_given?

        carried  = false
        borrowed = false
        new_sequence = zip_reversed_sequences(other).map { |first_bit, second_bit|
          new_bit = yield first_bit, second_bit
          new_bit = new_bit.inc if carried
          new_bit = new_bit.dec if borrowed
          carried, borrowed = new_bit.carry?, new_bit.borrow?
          new_bit
        }.reverse

        self.class.new new_sequence
      end

      def zip_reversed_sequences(other)
        sequence.reverse.zip(other.sequence.reverse)
      end
    end
  end
end
