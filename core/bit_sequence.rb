require_relative 'bit/bit.rb'
require_relative 'operator.rb'
require_relative 'errors.rb'
require 'forwardable'

module Bitwiser
  module BitSequence # unsigned
    class Base
      extend Forwardable
      include OperationHelper
      include NativeOperator
      include LogicalOperator

      attr_reader :sequence, :size
      def_delegators :sequence, :map, :each, :inject

      def initialize(value, size=nil)
        size    ||= calculate_size(value)
        @sequence = create_filling(size - calculate_size(value), filling: filling_for(value)) +
                    cast(value).chars.map {|c| Bit.new(c.to_i)}
        @size     = sequence.size
      end

      # big_endian
      def to_i
        to_integer(sequence)
      end

      def dump
        sequence.join
      end
      alias_method :to_s,    :dump
      alias_method :inspect, :dump

      def values
        map(&:value)
      end
      alias_method :to_a, :values

      private

      def to_integer(sequence)
        sequence.inject(0) { |sum, bit| sum = sum * 2 + bit.value }
      end

      def create_filling(fill_size, filling: 0)
        raise InvalidValue.new 'size is too short' if fill_size.negative?
        raise InvalidValue unless [0, 1].include? filling

        [ Bit.new(filling) ] * fill_size
      end

      def filling_for(value)
        0
      end

      def cast_integer(value)
        raise InvalidValue.new, 'cannot cast negative value. use signed sequence instead' if value.negative?
        value.to_s(2)
      end

      def calculate_size(value)
        case value
        when Integer
          cast_integer(value).size
        when String
          value.size
        when Array
          value.size
        else
          raise InvalidValue.new 'failed to identify the value type given in the argument'
        end
      end

      def cast(value)
        return cast_integer(value) if value.is_a?(Integer)
        return value               if value.is_a?(String)  && value =~ /\A[01]+\z/
        return cast(value.join)    if value.is_a?(Array)

        raise InvalidValue.new 'failed to cast the given value into binary expression'
      end
    end
  end
end
