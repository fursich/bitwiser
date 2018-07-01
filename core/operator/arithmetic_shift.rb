module Bitwiser
  module Operator
    module ArithmeticShift
      def arithmetic_shift_left(n=1)
        self.class.new fill_right(n, filling: 0).slice(n..-1)
      end
      alias_method :asl, :arithmetic_shift_left

      def arithmetic_shift_right(n=1)
        self.class.new fill_left(n, filling: sign_bit.to_i).slice(0..size-1)
      end
      alias_method :asr, :arithmetic_shift_right
    end
  end
end
