module Bitwiser
  module Operator
    module LogicalShift
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
        self.class.new fill_left(n).slice(0..size-1)
      end
      alias_method :lsr, :logical_shift_right
    end
  end
end
