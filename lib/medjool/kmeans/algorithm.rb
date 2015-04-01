require 'set'

module KMeans

  def centroids_eql? a, b
    a.all? do |ci|
      b.any? do |cj|
        ci.all? do |i|
          cj.any? do |j|
            i.attr_eql? j
          end
        end
      end
    end
  end

  class Algorithm < Clustering::Algorithm

    attr_reader :centroids

    def initialize centroids, nodes
      super centroids.count, nodes
      @centroids = centroids
    end

    def run
      old_centroids = Set.new []
      centroids = Set.new @centroids
      centroid_clusters = {nil => nil}
      while centroids_eql? old_centroids, centroids
        old_centroids = centroids
        node_centroids = @nodes.each.with_object({}) do |node, h|
          h[node] = centroids.min_by do |c|
            node.distance(c)
          end
        end
        centroid_clusters = centroids.each.with_object({}) do |centroid, h|
          h[centroid] = KMeans::Cluster.new node_centroids.lazy.select do |n, c|
            c.attr_eql?(centroid)
          end.map do |n, c|
            n
          end
        end
        yield centroid_clusters if block_given?
        centroids = Set.new centroid_clusters.values.map do |cluster|
          cluster.mean
        end
      end
      return centroid_clusters
    end

  end

end