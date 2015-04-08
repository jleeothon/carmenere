module Clustering

  # Represents any node that can be used regardless of algorithm or cluster.
  class Node

    include Comparable

    attr_reader :name
    attr_reader :attributes

    def initialize name, attributes
      @name = name
      @cache = Hash.new
      @attributes = attributes
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
      c = @cache[other]
      if c
        c
      else
        @cache[other] = other.cache[self] = yield
      end
    end

    def attr_eql? other
      return @attributes == other.attributes
    end

    protected

    attr_reader :cache

  end

end