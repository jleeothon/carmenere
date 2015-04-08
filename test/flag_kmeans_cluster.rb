require 'medjool'

class FlagCluster < KMeans::Cluster

    def mean
        attributes = Hash.new
        numeric_attributes.each do |a|
            attributes[a] = self.reduce(0) { |m, f| f.attributes[a] }
            attributes[a] = attributes[a].fdiv(self.count)
        end
        
    end

end