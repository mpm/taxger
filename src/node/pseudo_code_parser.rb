class PseudoCodeParser
  attr_reader :tokens

  NUMBER = /^-?\d+/
  RESERVED = {
    multiply:  'multiply',
    divide:    'divide',
    substract: 'substract',
    add:       'add',
    valueOf:   'value_of',
    compareTo: 'compare_to',
    setScale:  'set_scale'
  }

  class ParserError < StandardError
  end

  def initialize(source, instance_vars)
    @buffer = StringScanner.new(source)
    @instance_vars = instance_vars
    @tokens = []
    parse
  end

  private

  def parse
    until @buffer.eos?
      parse_next
    end
  end

  def parse_next
    skip_spaces
    if @buffer.scan(/new BigDecimal/)
      @tokens << 'BigDecimal.new'
    elsif parse_number_or_identifier
      # ...
    elsif @buffer.scan(/,/)
      @tokens << ', '
    elsif ['&&', '>=', '<=', '==', '!='].include?(@buffer.peek(2))
      @tokens << " #{@buffer.getch + @buffer.getch} "
    elsif ['+', '-', '/', '*', '<' ,'>', '='].include?(@buffer.peek(1))
      @tokens << " #{@buffer.getch} "
    elsif ['.', '(', ')', '[', ']'].include?(@buffer.peek(1))
      @tokens << @buffer.getch
    else
      error('Unexpected token')
    end
  end

  def parse_number_or_identifier
    skip_spaces
    if @buffer.check(NUMBER)
      @tokens.push(@buffer.scan(NUMBER))
    elsif @buffer.check(/\w+/)
      token = @buffer.scan(/\w+/)
      if RESERVED[token.to_sym]
        token = RESERVED[token.to_sym]
      else
        token = "@#{token.downcase}" if @instance_vars.include?(token)
      end
      @tokens.push(token)
    else
      nil
    end
  end

  def skip_spaces
    @buffer.skip(/\s+/)
  end

  def error(description)
    raise ParserError.new("#{description} at position #{@buffer.pos+1}: \"#{@buffer.string}\"")
  end
end