class Node
  @@ident = 0
  def initialize
    @output = []
  end

  def output_buffer
    @output
  end

  def self.is_comment?(element)
    element.is_a?(Nokogiri::XML::Comment)
  end

  def self.is_text?(element)
    element.is_a?(Nokogiri::XML::Text)
  end

  protected

  def ident(&block)
    @@ident += 1
    yield
    @@ident -= 1
  end

  def output(node)
    if node.is_a?(String)
      @output << "#{'  ' * @@ident}#{node}".rstrip
    elsif node.is_a?(Node)
      @output += node.render
    elsif node.is_a?(Array)
      node.each { |n| output(n) }
    end
  end

  def comment(str)
    (str.is_a?(Array) ? str : [str]).map(&:strip).compact.each do |line|
      output("# #{str}")
    end
  end

  def linefeed
    output('')
  end
end

