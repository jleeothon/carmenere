require 'minitest/autorun'
require 'medjool'
require 'point'


def point_mean cluster
    x = cluster.reduce(0) { |m, p| m + p.x }.fdiv(cluster.count)
    y = cluster.reduce(0) { |m, p| m + p.y }.fdiv(cluster.count)
    Point.new "(#{x.round(2)}, #{y.round(2)})", x, y
end

class TestCluster < MiniTest::Unit::TestCase

  def setup
    @nodes = [
        Point.new(:'1', 1, 2), Point.new(:'2', 2, 3), Point.new(:'3', 2, 4),
        Point.new(:'4', 5, 2), Point.new(:'5', 6, 7), Point.new(:'6', 3, 4),
        Point.new(:'7', 7, 8), Point.new(:'8', 1, 4), Point.new(:'9', 4, 4),
        Point.new(:'10', 4, 3), Point.new(:'11', 4.5, 4), Point.new(:'12', 5, 5),
        Point.new(:'13', 6, 6), Point.new(:'14', 7, 7), Point.new(:'15', 7, 6),
        Point.new(:'16', 6, 8), Point.new(:'17', 6.5, 7), Point.new(:'18', 1, 3),
        Point.new(:'19', 5.5, 5.5), Point.new(:'20', 8, 8), Point.new(:'21', 7.5, 7.5),
        Point.new(:'22', 1, 5), Point.new(:'23', 3.5, 4), Point.new(:'24', 2.5, 4),
        Point.new(:'25', 2, 2), Point.new(:'26', 2, 5), Point.new(:'27', 1.5, 3.5),
        Point.new(:'28', 1.5, 5), Point.new(:'29', 1.5, 2), Point.new(:'30', 4.5, 2.5)
    ]
    @centroids = [Point.new(:a, 1, 2), Point.new(:b, 7, 7)]
    @algorithm = Medjool::KMeans::Algorithm.new(@centroids, @nodes) do |cluster|
        point_mean(cluster)
    end
  end

  def test_run
    puts @algorithm.run
  end

  def test_step
    puts "--------------------------"
    @algorithm.run do |s|
        puts s
        puts "--------"
    end
  end

end
