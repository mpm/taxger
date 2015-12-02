class CommentNode < Node
  def initialize(element)
    @comments = element.inner_text.split("\n").map(&:strip)
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

