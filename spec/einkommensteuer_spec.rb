require 'spec_helper'

module Taxger
  describe Einkommensteuer do
    {
      '2015' => [21_138_00,  1_162_59]
    }.each do |year, fields|
      it "calculates Einkommensteuer #{year}" do
        tax = Einkommensteuer.calculate(year, 70_000_00)
        expect(tax.ekst).to  eq(fields[0])
        expect(tax.solz).to  eq(fields[1])
      end
    end
  end
end
