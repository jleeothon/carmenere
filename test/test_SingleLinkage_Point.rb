require 'minitest/autorun'

require 'carmenere'

require 'point'

# 8              f
# 7
# 6        e
# 5      d
# 4
# 3  b
# 2c
# 1a
#  1 2 3 4 5 6 7 8

class TestSingleLinkageWithPoint < MiniTest::Unit::TestCase

  def setup
    @nodes = [
      Point.new(:a, 1, 1),
      Point.new(:b, 2, 3),
      Point.new(:c, 1, 2),
      Point.new(:d, 4, 5),
      Point.new(:e, 5, 6),
      Point.new(:f, 8, 8)
    ]
    @algorithm = Carmenere::SingleLinkage::Algorithm.new 2, @nodes
  end

  # def test_matrix_no_recursive
  #   assert_equal nil, @algorithm.distance_matrix[@nodes[0]][@nodes[0]]
  # end

  def test_step
    steps = [
      "{b}, {d}, {e}, {f}, {a, c}",
      "{d}, {e}, {f}, {b, a, c}",
      "{f}, {b, a, c}, {d, e}",
      "{f}, {b, a, c, d, e}"
    ]
    i = 0
    @algorithm.run do |cluster|
      assert_equal steps[i], cluster.join(", ")
      i += 1
    end
  end

  def test_run
    clusters = @algorithm.run
    assert_equal "{f}, {b, a, c, d, e}", clusters.join(", ")
  end

end
