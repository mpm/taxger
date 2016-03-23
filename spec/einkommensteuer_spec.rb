require 'spec_helper'

module Taxger
  describe Einkommensteuer do
    [
      ['2015', 260_000_00, 101_216_00, 5_566_88],
      ['2015',  70_000_00,  21_138_00, 1_162_59],
      ['2015',  50_000_00,  12_757_00,   701_63],
      ['2015',  20_000_00,   2_611_00,   143_60],
      ['2015',  10_000_00,     237_00,        0],
      ['2015',   5_000_00,          0,        0]
    ].each do |dataset|
      (year, brutto, ekst, solz) = dataset
      it "calculates Einkommensteuer for #{brutto / 100.0} EUR in #{year}" do
        tax = Einkommensteuer.calculate(year, brutto)
        expect(tax.ekst).to eq(ekst)
        expect(tax.solz).to eq(solz)
      end
    end
  end
end
