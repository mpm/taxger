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

class Converter
  XML_PATH = File.expand_path('../xml/', __FILE__)
  GENERATED_PATH = File.expand_path('../generated/', __FILE__)
  URI = 'https://www.bmf-steuerrechner.de/pruefdaten/'
  FILES = [
  'Lohnsteuer2016.xml',
  'Lohnsteuer2015Dezember.xml',
  'Lohnsteuer2015BisNovember.xml',
  'Lohnsteuer2014.xml',
  'Lohnsteuer2013_2.xml',
  'Lohnsteuer2012.xml',
  'Lohnsteuer2011Dezember.xml',
  'Lohnsteuer2011BisNovember.xml',
  'Lohnsteuer2010Big.xml',
  'Lohnsteuer2009Big.xml',
  'Lohnsteuer2008Big.xml',
  'Lohnsteuer2007Big.xml',
  'Lohnsteuer2006Big.xml']

  def self.download_all!
    FILES.each do |file|
      puts "Downloading #{file}"
      `curl #{URI}#{file} -s -o #{File.join(XML_PATH, file)}`
    end
  end

  def self.generate_all!
    FILES.each do |file|
      generate_file(file)
    end
  end

  def self.generate_file(file)
    code = CodeTree.new(Nokogiri::XML(File.read(File.join(XML_PATH, file))))
    name = file.split('.').first.downcase
    puts "Generating #{name}.rb"
    File.open(File.join(GENERATED_PATH, "#{name}.rb"), 'w+') do |f|
      f.puts code.render
    end
  end
end

#require './generated/lohnsteuer2016.rb'
#@s = Lohnsteuer2016Big.new(stkl: 1, lzz: 1, re4: BigDecimal.new(70000 * 100))
