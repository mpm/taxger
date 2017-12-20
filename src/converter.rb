require 'nokogiri'
require 'strscan'
require 'bigdecimal'

require 'node/node'
require 'node/comment_node.rb'
require 'node/expr_node.rb'
require 'node/method_node.rb'
require 'node/initializer_node.rb'
require 'node/method_call_node.rb'
require 'node/conditional_node.rb'
require 'node/source_node.rb'
require 'node/class_node.rb'
require 'node/var_block_node.rb'
require 'node/pseudo_code_parser.rb'

require 'code_tree.rb'

module Taxger
  class Converter
    XML_PATH = File.expand_path('../xml/', __FILE__)
    GENERATED_PATH = File.expand_path('../generated/', __FILE__)
    URI = 'https://www.bmf-steuerrechner.de/pruefdaten/'
    FILES = {
    'Lohnsteuer2018.xml'            => 'Lohnsteuer2018',
    'Lohnsteuer2017.xml'            => 'Lohnsteuer2017',
    'Lohnsteuer2016.xml'            => 'Lohnsteuer2016',
    'Lohnsteuer2015Dezember.xml'    => 'Lohnsteuer2015Dezember',
    'Lohnsteuer2015BisNovember.xml' => 'Lohnsteuer2015',
    'Lohnsteuer2014.xml'            => 'Lohnsteuer2014',
    'Lohnsteuer2013_2.xml'          => 'Lohnsteuer2013',
    'Lohnsteuer2012.xml'            => 'Lohnsteuer2012',
    'Lohnsteuer2011Dezember.xml'    => 'Lohnsteuer2011Dezember',
    'Lohnsteuer2011BisNovember.xml' => 'Lohnsteuer2011',
    'Lohnsteuer2010Big.xml'         => 'Lohnsteuer2010',
    'Lohnsteuer2009Big.xml'         => 'Lohnsteuer2009',
    'Lohnsteuer2008Big.xml'         => 'Lohnsteuer2008',
    'Lohnsteuer2007Big.xml'         => 'Lohnsteuer2007',
    'Lohnsteuer2006Big.xml'         => 'Lohnsteuer2006'}

    def self.download_all!
      FILES.keys.each do |file|
        puts "Downloading #{file}"
        `curl #{URI}#{file} -s -o #{File.join(XML_PATH, file)}`
      end
    end

    def self.generate_all!
      FILES.each do |file, class_name|
        generate_file(file, class_name)
      end
    end

    def self.generate_file(file, class_name)
      code = CodeTree.new(Nokogiri::XML(File.read(File.join(XML_PATH, file))), class_name)
      name = file.split('.').first.downcase
      puts "Generating #{name}.rb"
      File.open(File.join(GENERATED_PATH, "#{class_name.downcase}.rb"), 'w+') do |f|
        f.puts code.render
      end
    end
  end
end
