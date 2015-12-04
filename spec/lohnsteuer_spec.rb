require 'spec_helper'

module Taxger
  module Lohnsteuer
    describe Lohnsteuer do
      {
       '2012'         => [17_560, 965.80],
       '2013'         => [17_560, 965.80],
       '2014'         => [17_348, 954.14],
       '2015'         => [17_376, 955.68],
       '2015Dezember' => [17_354, 954.47]
      }.each do |year, fields|
        it "calculates lohnsteuer and solidaritätszuschlag #{year}" do
          tax = Lohnsteuer.calculate(year, stkl: 1, lzz: 1, re4: 70_000 * 100)
          expect(tax.lstlzz).to  eq(fields[0] * 100.0)
          expect(tax.solzlzz).to eq(fields[1] * 100.0)
        end
      end
    end
  end
end
