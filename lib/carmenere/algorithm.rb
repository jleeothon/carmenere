module Carmenere

  class Algorithm

    attr_reader :nodes

    attr_reader :distance_matrix

    def initialize k, nodes
      @k = k
      @nodes = Set.new(nodes).freeze
      @clusters = Set.new(@nodes.map{ |n| Cluster.new([n]) })
      @distance_matrix = @nodes.each.with_object({}) do |i, row|
        row[i] = @nodes.each.with_object({}) do |j, col|
          col[j] = i.distance(j) if i != j
        end
      end
    end

    # If a block is provided, it should yield each iteration of the clusters,
    # otherwise, just returns the final state of the space.
    def run
      raise NotImplementedError.new
    end

  end

end