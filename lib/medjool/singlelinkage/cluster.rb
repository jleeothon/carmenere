module Medjool::SingleLinkage

  class Cluster < Medjool::Cluster

    # Minimum distance to other cluster
    def distance other
      self.reduce(nil) do |m, i|
        other.reduce(m) do |m, j|
          d = i.distance j
          m = if m.nil? or m > d then d else m end
        end
      end
    end

    def to_s
      "{" + self.reduce("") do |m, n|
        m += ", " unless m.empty?
        m += n.to_s
      end + "}"
    end

    def inspect
      self.to_s
    end

    def run
      raise NotImplementedError.new
    end

  end

end

