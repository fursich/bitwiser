module Bitwiser
  module Operator
    module Arithmetic
      def add(other)
        # TODO consider adding overflow/carry flag
        operate_each_byte_with(other) { |first_bit, second_bit|
          first_bit.add(second_bit)
        }
      end
      alias_method :+, :add

      def sub(other)
        # TODO consider adding overflow/borrow flag
        operate_each_byte_with(other) { |first_bit, second_bit|
          first_bit.sub(second_bit)
        }
      end
      alias_method :-, :sub

      def multiply(other)
        negative_sign = negative? ^ other.negative?

        zero_sequence = BitSequence::Base.new '0', size * 2 # for temporary purpose(unsigned)
        base_sequence = other.abs.map do |bit|
          if bit.to_bool
            BitSequence::Base.new abs.values, size * 2 # for temporary purpose(unsigned)
          else
            zero_sequence
          end
        end
        new_sequence = base_sequence.inject(zero_sequence) {|sum, bit| sum.lsl.add bit}

        result_sequence = negative_sign ? new_sequence.invert : new_sequence
        result_sequence.split.map{|res| self.class.new(res.values)}
      end
      alias_method :mul, :multiply
      alias_method :*, :multiply

      def increment
        add self.class.new(1, size)
      end
      alias_method :inc, :increment

      def decrement
        sub self.class.new(1, size)
      end
      alias_method :dec, :decrement

      def absolute
        # FIXME consider adding overflow flag (e.g. 10000.abs -> 10000)
        raise InvalidValue.new 'minimum negative number cannot be inverted' if minimum_negative_number?
        raise InvalidOperation.new 'Unsinged sequence cannot be inverted' unless self.is_a? SignedSequence
        negative? ? invert : dup
      end
      alias_method :abs, :absolute

      def invert
        # FIXME consider adding overflow flag (e.g. 10000.abs -> 10000)
        raise InvalidValue.new 'minimum negative number cannot be inverted' if minimum_negative_number?
        self.not.increment
      end
      alias_method :inv, :invert
    end
  end
end
