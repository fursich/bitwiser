module Bitwiser
  module Operator
    module Native
      BINARY_OPERATORS = %i(and or xor)
      BINARY_OPERATORS.each do |operator|
        define_method(operator) { |other| operate_with other, operator }
      end

      UNARY_OPERATORS = %i(not)
      UNARY_OPERATORS.each do |operator|
        define_method(operator) { operate_self operator }
      end
    end
  end
end
