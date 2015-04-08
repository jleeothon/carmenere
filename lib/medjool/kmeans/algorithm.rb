require 'set'

module KMeans

  def self.centroids_eql? a, b
    (a.count == b.count) and a.all? do |cluster_i|
      puts "- #{cluster_i.class}"
      b.any? do |cluster_j|
        puts "- #{cluster_j.class}"
        cluster_i.all? do |node_i|
          cluster_j.any? do |node_j|
            node_i.attr_eql? node_j
          end
        end
      end
    end
  end

  class Algorithm < Clustering::Algorithm

    attr_reader :centroids

    def initialize centroids, nodes, &mean
      super centroids.count, nodes
      @mean = mean
      @centroids = centroids
    end

    def run
      old_centroids = Set.new
      centroids = Set.new @centroids
      centroid_clusters = {nil => nil}
      until KMeans::centroids_eql? old_centroids, centroids
        old_centroids = centroids
        node_centroids = @nodes.each.with_object({}) do |node, h|
          h[node] = centroids.min_by do |c|
            node.distance(c)
          end
        end
        centroid_clusters = centroids.each.with_object({}) do |centroid, h|
          nodes = node_centroids.lazy.select do |n, c|
            c.attr_eql?(centroid)
          end.map do |n, c|
            n
          end
          h[centroid] = KMeans::Cluster.new nodes
        end
        yield centroid_clusters if block_given?
        centroids = Set.new centroid_clusters.values.map do |cluster|
          @mean.call(cluster)
        end
      end
      centroid_clusters
    end

  end

end