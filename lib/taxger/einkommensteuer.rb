module Taxger
  module Einkommensteuer
    class Error < StandardError; end
    class Result
      attr_accessor :ekst, :solz

      def initialize(ekst, solz)
        @ekst = ekst
        @solz = solz
      end
    end

    extend self

    F = 10**-8

    ZONES = {
      # Values are taken from this table:
      # https://de.wikipedia.org/wiki/Einkommensteuer_(Deutschland)#Entwicklung_der_Parameter
      # Non-existent parameters for E(i) with i > 3 have to be replaced with nil 
      # Non-existent parameters for a(i) with i > 2 have to be 0.
      '2010' => [
         #   E(0),   a(1) * F,   b(1),        0
         [  8_003, 912.17 * F,   0.14,        0],

         #   E(1),   a(2) * F,   b(2),     S(1)
         [ 13_469, 228.74 * F, 0.2397,     1038],

         #   E(2),  a(3) (=0),   b(3),     S(2)
         [ 52_881,          0,   0.42,   14_038.5],

         #   E(3),  a(4) (=0),   b(4),     S(3)
         [250_730,          0,   0.45,   97_134.5]
      ],

      # no change from 2010
      '2011' => [
         [  8_003, 912.17 * F,   0.14,        0],
         [ 13_469, 228.74 * F, 0.2397,     1038],
         [ 52_881,          0,   0.42,   14_038.5],
         [250_730,          0,   0.45,   97_134.5]
      ],

      # no change from 2010
      '2012' => [
         [  8_003, 912.17 * F,   0.14,        0],
         [ 13_469, 228.74 * F, 0.2397,     1038],
         [ 52_881,          0,   0.42,   14_038.5],
         [250_730,          0,   0.45,   97_134.5]
      ],

      '2013' => [
         [  8_130, 933.70 * F,   0.14,        0],
         [ 13_469, 228.74 * F, 0.2397,     1014],
         [ 52_881,          0,   0.42,   -8196 + 0.42 * 52_881],
         [250_730,          0,   0.45,   -15718 + 0.45 * 250_730]
      ],

      '2014' => [
         [  8_354, 974.58 * F,   0.14,        0],
         [ 13_469, 228.74 * F, 0.2397,      971],
         [ 52_881,          0,   0.42,   -8239 + 0.42 * 52_881],
         [250_730,          0,   0.45,   -15761 + 0.45 * 250_730]
      ],

      '2015' => [
         [  8_472,  997.6 * F,   0.14,        0],
         [ 13_469, 228.74 * F, 0.2397,   948.68],
         [ 52_881,          0,   0.42,   13_949],
         [250_730,          0,   0.45,   97_045]
      ],

      '2016' => [
         [  8_652, 993.62 * F,   0.14,        0],
         [ 13_669, 225.40 * F, 0.2397,   952.48],
         [ 53_665,          0,   0.42,     -8394.14 + 0.42 * 53_665],
         [254_447,          0,   0.45,   -16027.52 + 0.45 * 254_447]
      ],
    }

    def calculate(year, income)
      if !ZONES[year.to_s]
        raise Einkommensteuer::Error.new("No data available for year #{year}")
      end

      income = income * 0.01
      ZONES[year.to_s].reverse.each do |zone|
        (zone_start, a, b, c) = zone
        if income >= zone_start + 1
          taxable = income - zone_start
          tax = (a * (taxable ** 2) + b * taxable + c).to_i * 100

          # Vereinfachte Berechnung des Solidaritätszuschlagsfreibetrags:
          # Nicht gültig für Steuerklasse III (162 EUR statt 81 EUR) und abweichend,
          # wenn Lohnsteuer in verschiedenen Monaten jeweils unter- und überhalb der
          # Grenze lag.
          solz = tax > 81_00 * 12 ? (tax * 0.055).to_i : 0
          return Result.new(tax, solz)
        end
      end
      Result.new(0, 0)
    end
  end
end
