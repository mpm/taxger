# Taxger

This gem contains tools to calcuate taxes in Germany.

Currently supported is calculating Lohnsteuer. To achieve this,
The pseudo code describing tax caluculations from the Minstery of
Finance is used to automatically create Ruby code from this.

__(German description for SEO purposes):__

Dieses Gem enthält Routinen zum Berechnen von Steuern in Deutschland
(Lohnsteuer).

Der Programmcode zur Berechnung der Lohnsteuer wurde automatisch anhand
der vom Bundesministerium für Finanzen zur Verfügung gestellten
Pseudocode-Vorlagen erstellt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'taxger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install taxger

## Usage

### Lohnsteuer

```ruby
require 'taxger'

# calculate Lohnsteuer for 2015:
# stkl: 1, # Steuerklasse I (stkl), 70.000,00 EUR
# lzz: 1,  # Lohnzahlungszeitraum Jährlich (Salary re4 contains yearly
#          # salary)
# re4: 70_000 * 100 # Salary is 70.000,00 EUR
tax = Taxger::Lohnsteuer.calculate(2015, stkl: 1, lzz: 1, re4: 70_000 * 100)
puts tax.lstlzz # Lohnsteuer für Lohnzahlungszeitraum (Income tax for
                # specified interval of one year
```

Have a look into the files in `lib/taxger/lohnsteuer/*.rb` to see
possible values.
The `initialize` method contains all parameters below the `# INPUTS`
section- comments are taken from the official pseudo code sources.

Resulting values are listed under `# OUTPUTS` with comments (and can be
accessed with getter methods under the same name).

[Further documentation on field names is available from official
government resources](https://www.bmf-steuerrechner.de/interface/pap.jsp)

### Einkommensteuer
```ruby
require 'taxger'

# calculate income tax for 2015:
tax = Taxger::Einkommensteuer.calculate(2015, 70_000 * 100)
puts tax.ekst # => 21138_00 (Income tax in cents)
puts tax.solz # =>  1162_59 (Solidaritätszuschlag in cents)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Regenerating source files

The code to calculate Lohnsteuer (see files in `lib/taxger/lohnsteuer/`
are auto generated from XML pseudo code given by the Ministery of
Finance.

To regenerate or update these files, have a look into `src/README.md`.

## Contributors

Original author (2015):

* [Malte Münchert](https://github.com/mpm)

Contributions from [Wundertax GmbH](https://www.wundertax.de/)

* [@jalyna](https://github.com/jalyna)
* [@bryszard](https://github.com/bryszard)

# Submitting contributions

Bug reports and pull requests are welcome on GitHub at https://github.com/mpm/taxger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
