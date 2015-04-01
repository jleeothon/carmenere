require 'json'

require 'medjool'

class Flag < Clustering::Node  

  Attributes = [
    [:bars, 0.5],
    [:stripes, 0.5],
    [:colours, 1],
    [:red, 1],
    [:green, 1],
    [:blue, 1],
    [:gold, 1],
    [:white, 1],
    [:black, 1],
    [:orange, 1],
    [:mainhue, 1],
    [:circles, 0.5],
    [:crosses, 0.5],
    [:saltires, 1],
    [:quarters, 1],
    [:sunstars, 0.5],
    [:crescent, 0.5],
    [:triangle, 1],
    [:icon, 0.5],
    [:animate, 0.5],
    [:text, 1],
    [:topleft, 1],
    [:botright, 1]
  ]

  # A hash of attributes
  attr_reader :attributes

  def initialize country, attributes
    super country, attributes
    @cache = Hash.new
  end

  def distance other
    self.cache_distance(other) do
      Attributes.reduce(0) do |m, (a, v)|
        selfA = @attributes[a]
        otherA = other.attributes[a]
        m + if selfA.is_a? String
          if selfA == otherA then 0 else v end
        elsif selfA.is_a? Fixnum
          (selfA - otherA).abs * v
        else
          raise "Attributes not string nor number but #{selfA.class}"
        end
      end
    end
  end

  def self.load filename
    json = JSON::load File::open(filename)
    json.map do |attributes|
      country = attributes.shift
      attributes = attributes.slice(6..-1).each.with_index.with_object({}) do |(a, i), h|
        k = Attributes[i][0]
        h[k] = a
      end
      Flag.new country, attributes
    end
  end

end
