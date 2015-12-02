class InitializerNode < MethodNode
  def initialize(element, options = {})
    element['name'] = 'initialize'
    super(element, options)
  end

  def render
    super
  end
end

