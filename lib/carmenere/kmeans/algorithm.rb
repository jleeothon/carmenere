require 'set'

module Carmenere::KMeans

  def self.centroids_eql? old_centroids, new_centroids
    [old_centroids, new_centroids].each do |i|
      unless i.is_a?(Set)
        raise TypeError.new("#{i.class} is not Set of Node")
      end
      unless i.all?{ |j| j.is_a?(Carmenere::Node) }
        types = i.map{|j| j.class}
        raise TypeError.new("Elements of Cluster are of types #{types}")
      end
    end
    old_centroids.count == new_centroids.count and old_centroids.all? do |i|
      new_centroids.any? do |j|
        i.attr_eql? j
      end
    end
  end

  class Algorithm < Carmenere::Algorithm

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
      until Carmenere::KMeans::centroids_eql? old_centroids, centroids
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
          h[centroid] = Carmenere::KMeans::Cluster.new nodes
        end
        yield centroid_clusters if block_given?
        centroids = centroid_clusters.values.reject do |cluster|
          cluster.empty?
        end.map do |cluster|
          @mean.call(cluster)
        end
        centroids = Set.new centroids
      end
      centroid_clusters
    end

  end

end