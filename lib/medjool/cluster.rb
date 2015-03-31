require 'set'

class Cluster < Set

  def initialize algorithm, nodes
    unless nodes.is_a?(Array) and nodes.each{ |n| n.is_a?(Node) }
      raise ArgumentError.new "nodes is not an array of nodes"
    end
  end

  # Minimum distance to other cluster
  def distance other
    self.reduce(nil) do |m, n|
      other.reduce(m) do |m, j|
        d = i.distance j
        m = if min.nil? or min > d then d else min end
      end
    end
  end

  def to_s
    "{" + self.reduce("") do |m, n|
      m + ", " unless m.empty?
      m + n.to_s
    end + "}"
  end

  def inspect
    self.to_s
  end

end