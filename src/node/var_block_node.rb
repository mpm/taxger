class VarBlockNode < Node
  def initialize(element, options = {})
    @tag = options[:tag] || (raise 'Specify a :tag name')
    @options = options
    @name = element.name
    @elements = element.children
    super()
  end

  def render
    comment @name
    comments = []
    @elements.each do |line|
      if Node.is_comment?(line)
        comments << CommentNode.new(line)
      elsif Node.is_text?(line)
        if line.inner_text.strip != ''
          raise UnknownTextError.new(line)
        end
      elsif line.name == @tag.to_s.upcase
        type = @options[:show_type] ? " # #{line.attr('type')}" : nil
        if comments.size > 0
          linefeed
          output comments
        end
        if line.attr('value')
          value = PseudoCode.parse_constant_value(line.attr('value'))
        else
          value = PseudoCode.parse_default(line.attr('default'), line.attr('type'))
        end
        output "#{PseudoCode.parse_var(line.attr('name')).ljust(15)} = #{value.ljust(20)}#{type}"
        comments = []
      else
        raise UnknownTagError.new(line)
      end
    end
    linefeed
  end
end
