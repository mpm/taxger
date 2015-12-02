class MethodCallNode < Node
  def initialize(element)
    @method = element.attr('method')
    super()
  end

  def render
    output("#{PseudoCode.parse_method_name(@method)}")
    output_buffer
  end
end

