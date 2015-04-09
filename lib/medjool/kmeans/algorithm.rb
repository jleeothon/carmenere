require 'set'

module Medjool::KMeans

  def self.centroids_eql? old_centroids, new_centroids
    [old_centroids, new_centroids].each do |i|
      unless i.is_a?(Set) and i.all?{ |j| j.is_a?(Medjool::Node) }
        raise TypeError.new("#{i.class} is not Set of Node")
      end
    end
    old_centroids.count == new_centroids.count and old_centroids.all? do |i|
      new_centroids.any? do |j|
        i.attr_eql? j
      end
    end
  end

  class Algorithm < Medjool::Algorithm

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
      until Medjool::KMeans::centroids_eql? old_centroids, centroids
        old_centroids = centroids
        node_centroids = @nodes.each.with_object({}) do |node, h|
          h[node] = centroids.min_by do |c|
            node.distance(c)
          end
        end
        centroid_clusters = centroids.each.with_object({}) do |centroid, h|
          nodes = node_centroids.lazy.select do |_, c|
            c.attr_eql?(centroid)
          end.map do |n, c|
            n
          end
          h[centroid] = Medjool::KMeans::Cluster.new nodes
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