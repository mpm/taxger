require 'bigdecimal'

module Taxger
  module Lohnsteuer
    class BigDecimal < BigDecimal
      def multiply(value)
        BigDecimal.new(self * value)
      end

      def subtract(value)
        BigDecimal.new(self - value)
      end

      def divide(value, scale = nil, rounding=nil)
        if scale && rounding
          BigDecimal.new(self / value).set_scale(scale, rounding)
        elsif scale
          BigDecimal.new(self / value).set_scale(scale)
        else
          BigDecimal.new(self / value)
        end
      end

      def add(value)
        BigDecimal.new(self + value)
      end

      def set_scale(scale, rounding=nil)
        if rounding
          BigDecimal.new(self.round(scale, rounding))
        else
          BigDecimal.new(self.round(scale))
        end
      end

      def compare_to(value)
        if self < value
          -1
        elsif self == value
          0
        elsif self > value
          1
        end
      end

      def self.value_of(float)
        new(float, 16)
      end

      def self.ZERO
        new(0)
      end

      def self.ONE
        new(1)
      end

      def self.TEN
        new(10)
      end

      def self.ROUND_UP
        BigDecimal::ROUND_UP
      end

      def self.ROUND_DOWN
        BigDecimal::ROUND_DOWN
      end
    end
  end
end

