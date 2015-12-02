class ExprNode < Node
  def initialize(element)
    @expression = element.attr('exec')
    # TODO: parse expression hard core
    super()
  end

  def render
    output(PseudoCode.parse_expr(@expression))
    #linefeed
    output_buffer
  end
end
