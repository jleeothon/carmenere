class Node

  include Comparable

  attr_reader :name

  def initialize name
    @name = name
  end

  def <=> node
    @name <=> node.name
  end

  def hash
    @name.hash
  end

  def to_s
    @name
  end

  def inspect
    @name
  end

  def distance other
    raise NotImplementedError.new
  end

end

class Point < Node
  attr_reader :x, :y

  def initialize name, x, y
    super name
    @x = x
    @y = y
  end

  def distance other
    (@x - other.x) ** 2 + (@y - other.y) ** 2
  end

  def to_s
    super.to_s
  end

end