class ConditionalNode < Node
  def initialize(element)
    @cond_expr = element.attr('expr')
    @then = SourceNode.new(element.children.css('THEN').children)
    @else = SourceNode.new(element.children.css('ELSE').children)
    super()
  end

  def render
    output("if #{PseudoCode.parse_expr(@cond_expr)}")
    ident do
      output @then
    end
    output('else')
    ident do
      output @else
    end
    output('end')
    #linefeed
    output_buffer
  end
end
