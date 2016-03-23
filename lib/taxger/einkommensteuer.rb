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
      '2015' => [
         [  8_473,  13_469,  997.6 * F,   0.14,        0,   -8_472],
         [ 13_470,  52_881, 228.74 * F, 0.2397,   948.68,  -13_469],
         [ 52_882, 250_730,          0,   0.42,   13_949,  -52_881],
         [250_731,     nil,          0,   0.45,   97_045, -250_730]
      ]
    }

    def calculate(year, income)
      if !ZONES[year.to_s]
        raise Einkommensteuer::Error.new("No data available for year #{year}")
      end

      income = income * 0.01
      ZONES[year.to_s].reverse.each do |zone|
        (zone_start, zone_end, a, b, c, subs) = zone
        if income >= zone_start
          taxable = income + subs
          tax = (a * (taxable * taxable) + b * taxable + c).to_i * 100

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
