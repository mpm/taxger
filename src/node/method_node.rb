class MethodNode < Node
  def initialize(element, options = {})
    @options = options
    @name = element.attr('name')
    @body = SourceNode.new(element.children)
    super()
  end

  def render
    if @options[:description] && @options[:description].length > 0
      output(@options[:description])
    end
    output("def #{PseudoCode.parse_method_name(@name)}")
    ident do
      output(@body)
    end
    output('end')
    linefeed
    output_buffer
  end
end
