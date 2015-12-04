class ClassNode < Node
  def initialize(name, content, namespaces)
    @namespaces = namespaces.reverse
    @name = name
    @content = content
    super()
  end

  def render
    render_with_namespace(@namespaces)
    output_buffer
  end

  private

  def render_with_namespace(namespaces)
    if namespaces.size > 0
      output "module #{namespaces.pop}"
      ident { render_with_namespace(namespaces) }
      output "end"
    else
      output "class #{@name}"
      ident do
        output(@content)
      end
      output 'end'
    end
  end
end

