src = File.expand_path('../src/', __FILE__)
$LOAD_PATH.unshift(src) unless $LOAD_PATH.include?(src)

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require './src/converter.rb'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :taxger do
  namespace :source do
    task :download do
      Taxger::Converter.download_all!
    end

    task :generate do
      Taxger::Converter.generate_all!
    end
  end
end
