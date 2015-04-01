require 'medjool'

class Point < Clustering::Node

  def initialize name, x, y
    super name, {:x => x, :y => y}
  end

  def distance other
    super(other) do
      (self.x - other.x) ** 2 + (self.y - other.y) ** 2
    end
  end

  def to_s
    super.to_s
  end

  def x
    @attributes[:x]
  end

  def y
    @attributes[:y]
  end

end
