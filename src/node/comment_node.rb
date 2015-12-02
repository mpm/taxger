class CommentNode < Node
  def initialize(element)
    if element.is_a?(String)
      @comments = [element]
    else
      @comments = element.inner_text.split("\n").map(&:strip)
    end
    super()
  end

  def render
    @comments.each do |line|
      comment(line)
    end
    #linefeed if @comments.size > 0
    output_buffer
  end
end

