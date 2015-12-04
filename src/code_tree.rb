class CodeTree
  attr_accessor :nodes

  def initialize(xml, class_name = nil)
    @class_name = class_name
    @xml = xml
    @nodes = []
    @internals = []
    @var = {}
    @var[:outputs] = @xml.css('OUTPUT').map { |e| e.attr('name') }
    @var[:inputs] = @xml.css('INPUT').map { |e| e.attr('name') }
    @var[:internals] = @xml.css('INTERNAL').map { |e| e.attr('name') }
    @var[:constants] = @xml.css('CONSTANT').map { |e| e.attr('name') }
    @instance_vars = []
    PseudoCode.set_vars(@var)
    parse_vars
    parse_methods
  end

  def render
    ClassNode.new(@class_name || @xml.css('PAP').attr('name'), @nodes, ['Taxger', 'Lohnsteuer']).render
  end

  private

  def parse_vars
    @instance_vars << VarBlockNode.new(@xml.css('INPUTS').first, tag: :input, show_type: true)
    @instance_vars << VarBlockNode.new(@xml.css('OUTPUTS').first, tag: :output, show_type: true)
    @instance_vars << VarBlockNode.new(@xml.css('INTERNALS').first, tag: :internal)
    @nodes << VarBlockNode.new(@xml.css('CONSTANTS').first, tag: :constant)
  end

  def parse_methods
    comments = []
    @xml.xpath('/PAP/METHODS/METHOD').each do |line|
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
        @nodes << InitializerNode.new(line, @instance_vars, @var, description: comments)
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
    parser = PseudoCodeParser.new(pseudo_code.strip, @instance_vars)
    parser.tokens.join
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

  def self.parse_default(default, type)
    if default
      parser = PseudoCodeParser.new(default.strip, @instance_vars)
      parser.tokens.join
    else
      case type
      when 'int'
        '0'
      when 'double'
        '0.0'
      when 'float'
        '0.0'
      when 'BigDecimal'
        'BigDecimal.new(0)'
      end
    end
  end

  def self.parse_constant_value(value)
    if value[0] == '{'
      list = value[1..-2].split(',').map do |field|
        PseudoCodeParser.new(field.strip, @instance_vars).tokens.join
      end
      lines = []
      while (list != [])
        lines << list.shift(4)
      end
      '[' + lines.map { |items| items.join(', ') }.join(",\n#{' ' * 20}") + ']'
    else
      PseudoCodeParser.new(value.strip, @instance_vars).tokens.join
    end
  end
end



