module SingleLinkage

  class Algorithm < Clustering::Algorithm

    attr_reader :nodes

    attr_reader :distance_matrix

    def initialize k, nodes
      super k, nodes
    end

    # If step is true, then yields a copy of the array of clusters
    def run
      (nodes.size - @k).times do
        a, b = self.closest_clusters
        @clusters.delete a
        @clusters.delete b
        @clusters.add Cluster.new(a | b)
        yield @clusters.to_a if block_given?
      end
      @clusters.to_a
    end

    def closest_clusters
      @clusters.reduce(nil) do |m, i|
        @clusters.reduce(m) do |m, j|
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

end

