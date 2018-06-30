module Bitwiser
  module BitOperator
    def add(other)
      new_bit = xor(other)
      new_bit.carry! if bool_value && other.to_bool
      new_bit
    end

    def sub(other)
      new_bit = xor(other)
      new_bit.borrow! if !bool_value && other.to_bool
      new_bit
    end

    def xor(other)
      self.class.build_with_bool bool_value != other.to_bool
    end

    def not
      self.class.build_with_bool !bool_value
    end

    def and(other)
      self.class.build_with_bool bool_value && other.to_bool
    end

    def or(other)
      self.class.build_with_bool bool_value || other.to_bool
    end
  end
end
