require 'minitest/autorun'
require 'minitest/pride'

require 'carmenere'

require 'flag'


def flag_mean cluster
  count = cluster.count
  return nil if count.zero?
  attributes = Hash.new
  Flag::NumericShapes.each do |a|
    attributes[a] = cluster.reduce(0) do |m, f|
      m + f.attributes[a] / count
    end
  end
  Flag::BinaryColors.each do |a|
     attributes[a] = cluster.reduce(0){ |m, f| m + f.attributes[a] } / count 
  end
  Flag::BinaryShapes.each do |a|
    attributes[a] = cluster.reduce(0){ |m, f| m + f.attributes[a] } / count 
  end
  Flag::TextColors.each do |a|
    frequencies = cluster.each.with_object(Hash.new 0) do |f, b|
      b[f.attributes[a]] += 1
    end
    attributes[a] = frequencies.max_by(attributes.count){ |k, v| v }.sort[0]
  end
  Flag.new :c, attributes
end


class TestFlagKMeansCluster < Minitest::Test

  def setup
  @flags = Flag::load 'test/flag.json'
  @centroids = [@flags[50], @flags[60], @flags[30], @flags[40]]
  @algorithm = Carmenere::KMeans::Algorithm.new(@centroids, @flags) do |cluster|
    flag_mean(cluster)
  end
  end

  def test_run
    puts @algorithm.run
  end

  def test_step
  @algorithm.run do |s|
    s.each do |c|
      puts
      puts
      puts c
    end
  end
  end

end