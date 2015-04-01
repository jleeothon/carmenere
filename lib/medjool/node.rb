module Clustering

  class Node

    include Comparable

    attr_reader :name

    def initialize name
      @name = name
      @cache = Hash.new
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
    
    def cache_distance other
      other.cache[self] = @cache[other] = yield
    end

    protected

    attr_reader :cache

  end

end