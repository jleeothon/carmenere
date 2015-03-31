class Algorithm

  attr_reader :nodes

  attr_reader :distance_matrix

  def initialize k, nodes
    @k = k
    @nodes = Set.new(nodes).freeze
    @clusters = Set.new(@nodes.map{ |n| Cluster.new(self, [n]) })
    @distance_matrix = @nodes.each.with_object {} do |i, row|
      row[i] = @nodes.each.with_object {} do |j, col|
        col[j] = i.distance(j) if i != j
      end
    end
  end

  # If step is true, then yields a copy of the array of clusters
  def run step=false
    (nodes.size - @k).times do
      a, b = self.closest_clusters
      @clusters = @clusters - [a, b] + [[a, b]]
      if step
        yield @clusters.to_a
      end
    end
    @clusters.to_a
  end

  def step
    self.run(step=true){ |c| yield c }
  end

  def closest_clusters
    @clusters.reduce nil do |m, i|
      @clusters.reduce m do |m, j|
        d = i.distance j
        m = if i != j and (m.nil? or m[2] > d)
          [i, j, d]
        else
          m
        end
      end
    end
  end

end
