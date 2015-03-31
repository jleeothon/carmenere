module Clustering

  class Node

    include Comparable

    attr_reader :name

    def initialize name
      @name = name
    end

    def <=> node
      @name <=> node.name
    end

    def hash
      @name.hash
    end

    def to_s
      @name
    end

    def inspect
      @name
    end

    def distance other
      raise NotImplementedError.new
    end

  end

end