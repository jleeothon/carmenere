require 'minitest/autorun'

load 'medjool.rb'

class TestCluster < MiniTest::Unit::TestCase

  def setup
    @nodes = [
      Point.new(:a, 1, 1),
      Point.new(:b, 2, 3),
      Point.new(:c, 1, 2),
      Point.new(:d, 4, 5),
      Point.new(:e, 5, 6),
      Point.new(:f, 8, 8)
    ]
    @cluster1 = Cluster.new nil, @nodes.slice(0..2)
    @cluster2 = Cluster.new nil, @nodes.slice(3..5)
  end

  def test_cluster_distance
    assert_equal 8, @cluster1.distance(@cluster2)
  end

end
