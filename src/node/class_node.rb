class ClassNode < Node
  def initialize(name, content)
    @name = name
    @content = content
    super()
  end

  def render
    output "class #{@name}"
    ident do
      output(@content)
    end
    output 'end'
    output_buffer
  end
end

