class SourceNode < Node
  attr_accessor :lines
  def initialize(elements)
    @lines = []
    lc = nil
    elements.each do |element|
      if element.name == 'EXECUTE'
        @lines << MethodCallNode.new(element)
        lc = nil
      elsif element.name == 'EVAL'
        @lines << ExprNode.new(element)
        lc = nil
      elsif element.name == 'IF'
        @lines << ConditionalNode.new(element)
        lc = @lines.last
      elsif element.name == 'ELSE'
        if lc
          puts 'WARNING: Orphaned ELSE block found, but assigning it to previous IF statement'
          lc.attach_else(element.xpath('./*'))
        else
          raise UnknownTagError.new("Orphaned ELSE block found: #{element.inspect}")
        end
      elsif Node.is_comment?(element)
        @lines << CommentNode.new(element)
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
    @lines.each do |line|
      output(line)
    end
    output_buffer
  end
end

