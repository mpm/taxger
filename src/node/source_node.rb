class SourceNode < Node
  def initialize(elements)
    @children = []
    elements.each do |element|
      if element.name == 'EXECUTE'
        @children << MethodCallNode.new(element)
      elsif element.name == 'EVAL'
        @children << ExprNode.new(element)
      elsif element.name == 'IF'
        @children << ConditionalNode.new(element)
      elsif Node.is_comment?(element)
        @children << CommentNode.new(element)
      elsif Node.is_text?(element)
        if element.inner_text.strip != ''
          raise UnknownTextError.new(element.inner_text)
        end
      else
        raise UnknownTagError.new("Unknown pseudo code element: #{element.inspect}")
      end
    end
    super()
  end

  def render
    @children.each do |child|
      output(child)
    end
    output_buffer
  end
end

