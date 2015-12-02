require './node/node.rb'

class CodeTree
  attr_accessor :nodes

  def initialize(xml)
    @xml = xml
    @nodes = []
    @internals = []
    @var = {}
    @var[:outputs] = @xml.css('OUTPUT').map { |e| e.attr('name') }
    @var[:inputs] = @xml.css('INPUT').map { |e| e.attr('name') }
    @var[:internals] = @xml.css('INTERNAL').map { |e| e.attr('name') }
    @var[:constants] = @xml.css('CONSTANT').map { |e| e.attr('name') }
    PseudoCode.set_vars(@var)
    parse_vars
    parse_methods
  end

  def render
    ClassNode.new(@xml.css('PAP').attr('name'), @nodes).render
  end

  private

  def parse_vars
    @nodes << VarBlockNode.new(@xml.css('CONSTANTS').first, tag: :constant)
    #@nodes << VarBlockNode.new(@xml.css('INTERNALS').first, tag: :internal)
    #@nodes << VarBlockNode.new(@xml.css('INPUTS').first, tag: :input, show_type: true)
    #@nodes << VarBlockNode.new(@xml.css('OUTPUTS').first, tag: :output, show_type: true)
  end

  def parse_methods
    comments = []
    @xml.css('METHODS').children.each do |line|
      if Node.is_comment?(line)
        comments << CommentNode.new(line)
      elsif Node.is_text?(line)
        if line.inner_text.strip != ''
          raise UnknownTextError.new(line)
        end
      elsif line.name == 'METHOD'
        @nodes << MethodNode.new(line, description: comments)
        comments = []
      elsif line.name == 'MAIN'
        @nodes << InitializerNode.new(line, description: comments)
        comments = []
      else
        raise UnknownTagError.new(line)
      end
    end
  end
end

class ParserError < StandardError
end

class UnknownTextError < ParserError
end

class UnknownTagError < ParserError
end

class PseudoCode
  def self.set_vars(var)
    @outputs = var[:outputs].sort { |b, a| a.length <=> b.length }
    @inputs = var[:inputs].sort { |b, a| a.length <=> b.length }
    @internals = var[:internals].sort { |b, a| a.length <=> b.length }
    @instance_vars = (@outputs + @inputs + @internals).sort { |b, a| a.length <=> b.length }
  end

  def self.parse_expr(pseudo_code)
    (@instance_vars).each do |v|
      pseudo_code.gsub!(v, "@#{v.downcase}")
    end
    c = pseudo_code.tr(' ', '')
    "-- #{c} --"
  end

  def self.parse_method_name(name)
    "#{name.downcase}"
  end

  def self.parse_var(name)
    if @instance_vars.include?(name)
      "@#{name.downcase}"
    else
      name
    end
  end

  def self.parse_default(default)
    if default == nil
      'nil'
    elsif %w(0 1 1.0).include?(default)
      default.to_s
    elsif ['new BigDecimal(0)', 'BigDecimal.ZERO'].include?(default)
      'BigDecimal.new(0)'
    else
      raise "Unknown default: #{default}"
    end
  end
end



class BigDecimal
  def multiply(value)
    self * value
  end

  def substract(value)
    self - value
  end

  def divide(value, scale = 0, rounding=nil)
    self / value
  end

  def set_scale(scale, rounding=nil)

  end

  def compare_to(value)
    if self < value
      -1
    elsif self == value
      0
    elsif self > value
      1
    end
  end

  def self.value_of(float)
    new(float)
  end
end
