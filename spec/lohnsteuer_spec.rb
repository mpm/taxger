require 'spec_helper'

module Taxger
  module Lohnsteuer
    describe Lohnsteuer do
      {
       '2006'         => [19_834, 1090.87],
       '2007'         => [19_716, 1084.38],
       '2008'         => [19_603, 1078.16],
       '2009'         => [19_329, 1063.09],
       '2010'         => [18_102,  995.61],
       '2011'         => [17_952,  987.36],
       '2011Dezember' => [17_918,  985.49],
       '2012'         => [17_754,  976.47],
       '2013'         => [17_560,  965.80],
       '2014'         => [17_348,  954.14],
       '2015'         => [17_376,  955.68],
       '2015Dezember' => [17_354,  954.47]
      }.each do |year, fields|
        it "calculates Lohnsteuer and Solidaritätszuschlag #{year}" do
          tax = Lohnsteuer.calculate(year, stkl: 1, lzz: 1, re4: 70_000 * 100)
          expect(tax.lstlzz).to  eq(fields[0] * 100.0)
          expect(tax.solzlzz).to eq(fields[1] * 100.0)
        end
      end
    end
  end
end
