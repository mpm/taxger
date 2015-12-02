class InitializerNode < Node
  def initialize(element, instance_vars, var, options = {})
    @options = options
    @name = element.attr('name')
    @instance_vars = instance_vars
    @var = var
    @body = SourceNode.new(element.xpath('./*'))
    super()
  end

  def render
    output('INPUT_VARS = ' + @var[:inputs].map(&:downcase).map(&:to_sym).inspect)
    output('OUTPUT_VARS = ' + @var[:outputs].map(&:downcase).map(&:to_sym).inspect)
    if @options[:description] && @options[:description].length > 0
      output(@options[:description])
    end
    output('def initialize(params)')
    ident do
      output 'raise "Unknown parameters: #{params.keys - INPUT_VARS}" if params.keys - INPUT_VARS != []'
      output @instance_vars
      output 'params.each do |key, value|'
      output '  instance_variable_set("@#{key}", value)'
      output 'end'
      linefeed
      output @body
    end
    output('end')
    linefeed
    output('def results')
    ident do
      output 'Hash[OUTPUT_VARS.map { |key| [key, instance_variable_get("@#{key}")] }]'
    end
    output('end')
    linefeed
    output('private')
    linefeed
    output_buffer
  end
end
