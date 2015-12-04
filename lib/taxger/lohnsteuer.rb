require 'taxger/lohnsteuer/bigdecimal'
require 'taxger/lohnsteuer/lohnsteuer2006'
require 'taxger/lohnsteuer/lohnsteuer2007'
require 'taxger/lohnsteuer/lohnsteuer2008'
require 'taxger/lohnsteuer/lohnsteuer2009'
require 'taxger/lohnsteuer/lohnsteuer2010'
require 'taxger/lohnsteuer/lohnsteuer2011'
require 'taxger/lohnsteuer/lohnsteuer2011dezember'
require 'taxger/lohnsteuer/lohnsteuer2012'
require 'taxger/lohnsteuer/lohnsteuer2013'
require 'taxger/lohnsteuer/lohnsteuer2014'
require 'taxger/lohnsteuer/lohnsteuer2015'
require 'taxger/lohnsteuer/lohnsteuer2015dezember'
require 'taxger/lohnsteuer/lohnsteuer2016'

module Taxger
  module Lohnsteuer
    extend self

    def calculate(year, input)
      input = Hash[input.map do |key, value|
        [key, Taxger::Lohnsteuer::BigDecimal.new(value)]
      end]
      lst = Object.const_get("Taxger::Lohnsteuer::Lohnsteuer#{year}")
      lst.new(input)
    end
  end
end
