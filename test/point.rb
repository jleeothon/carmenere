require 'medjool'

class Point < Clustering::Node
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
