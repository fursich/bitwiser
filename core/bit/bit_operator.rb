module Bitwiser
  module BitOperator
    def add(other)
      new_bit = xor(other)
      new_bit.send :carry! if bool_value && other.to_bool
      new_bit
    end

    def sub(other)
      new_bit = xor(other)
      new_bit.send :borrow! if !bool_value && other.to_bool
      new_bit
    end

    def inc
      new_bit = self.not
      new_bit.send :carry! if bool_value
      new_bit
    end

    def dec
      new_bit = self.not
      new_bit.send :borrow! if !bool_value
      new_bit
    end

    def xor(other)
      self.class.build_with_bool bool_value != other.to_bool, flag_states
    end

    def not
      self.class.build_with_bool !bool_value, flag_states
    end

    def and(other)
      self.class.build_with_bool bool_value && other.to_bool, flag_states
    end

    def or(other)
      self.class.build_with_bool bool_value || other.to_bool, flag_states
    end
  end
end
