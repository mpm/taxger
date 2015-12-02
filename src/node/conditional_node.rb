class ConditionalNode < Node
  def initialize(element)
    @cond_expr = element.attr('expr')
    @then = SourceNode.new(element.xpath('./THEN/*'))
    @else = SourceNode.new(element.xpath('./ELSE/*'))
    super()
  end

  def attach_else(elements)
    if @else.lines.count > 0
      raise "Cannot attach another ELSE block to this conditional statement: #{elements}"
    else
      @else = SourceNode.new(elements)
    end
  end

  def render
    output("if #{PseudoCode.parse_expr(@cond_expr)}")
    ident do
      output @then
    end
    if @else.lines.count > 0
      output('else')
      ident do
        output @else
      end
    end
    output('end')
    output_buffer
  end
end

