require 'spec_helper'

module Taxger
  describe Einkommensteuer do
    {
      '2015' => [21_138.00,  1_162.59]
    }.each do |year, fields|
      it "calculates Einkommensteuer #{year}" do
        tax = Einkommensteuer.calculate(year, zve: 70_000 * 100)
        expect(tax).to  eq(fields[0] * 100.0)
      end
    end
  end
end
