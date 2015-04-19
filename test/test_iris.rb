# petallength
# petalwidth

require 'minitest/autorun'
require 'carmenere'
require 'point'

def point_mean cluster
    x = cluster.reduce(0) { |m, p| m + p.x }.fdiv(cluster.count)
    y = cluster.reduce(0) { |m, p| m + p.y }.fdiv(cluster.count)
    Point.new "(#{x.round(2)}, #{y.round(2)})", x, y
end

class TestCluster < MiniTest::Unit::TestCase

  def setup
    @nodes = [
        Point.new(:a1,    1.4,0.2),
        Point.new(:a2,  1.4,0.2),
        Point.new(:a3,  1.3,0.2),
        Point.new(:a4,  1.5,0.2),
        Point.new(:a5,  1.4,0.2),
        Point.new(:a6,  1.7,0.4),
        Point.new(:a7,  1.4,0.3),
        Point.new(:a8,  1.5,0.2),
        Point.new(:a9,  1.4,0.2),
        Point.new(:a10, 1.5,0.1),
        Point.new(:a11, 1.5,0.2),
        Point.new(:a12, 1.6,0.2),
        Point.new(:a13, 1.4,0.1),
        Point.new(:a14, 1.1,0.1),
        Point.new(:a15, 1.2,0.2),
        Point.new(:a16, 1.5,0.4),
        Point.new(:a17, 1.3,0.4),
        Point.new(:a18, 1.4,0.3),
        Point.new(:a19, 1.7,0.3),
        Point.new(:a20, 1.5,0.3),
        Point.new(:a21, 1.7,0.2),
        Point.new(:a22, 1.5,0.4),
        Point.new(:a23, 1.0,0.2),
        Point.new(:a24, 1.7,0.5),
        Point.new(:a25, 1.9,0.2),
        Point.new(:a26, 1.6,0.2),
        Point.new(:a27, 1.6,0.4),
        Point.new(:a28, 1.5,0.2),
        Point.new(:a29, 1.4,0.2),
        Point.new(:a30, 1.6,0.2),
        Point.new(:a31, 1.6,0.2),
        Point.new(:a32, 1.5,0.4),
        Point.new(:a33, 1.5,0.1),
        Point.new(:a34, 1.4,0.2),
        Point.new(:a35, 1.5,0.1),
        Point.new(:a36, 1.2,0.2),
        Point.new(:a37, 1.3,0.2),
        Point.new(:a38, 1.5,0.1),
        Point.new(:a39, 1.3,0.2),
        Point.new(:a40, 1.5,0.2),
        Point.new(:a41, 1.3,0.3),
        Point.new(:a42, 1.3,0.3),
        Point.new(:a43, 1.3,0.2),
        Point.new(:a44, 1.6,0.6),
        Point.new(:a45, 1.9,0.4),
        Point.new(:a46, 1.4,0.3),
        Point.new(:a47, 1.6,0.2),
        Point.new(:a48, 1.4,0.2),
        Point.new(:a49, 1.5,0.2),
        Point.new(:a50, 1.4,0.2),
        Point.new(:a51, 4.7,1.4),
        Point.new(:a52, 4.5,1.5),
        Point.new(:a53, 4.9,1.5),
        Point.new(:a54, 4.0,1.3),
        Point.new(:a55, 4.6,1.5),
        Point.new(:a56, 4.5,1.3),
        Point.new(:a57, 4.7,1.6),
        Point.new(:a58, 3.3,1.0),
        Point.new(:a59, 4.6,1.3),
        Point.new(:a60, 3.9,1.4),
        Point.new(:a61, 3.5,1.0),
        Point.new(:a62, 4.2,1.5),
        Point.new(:a63, 4.0,1.0),
        Point.new(:a64, 4.7,1.4),
        Point.new(:a65, 3.6,1.3),
        Point.new(:a66, 4.4,1.4),
        Point.new(:a67, 4.5,1.5),
        Point.new(:a68, 4.1,1.0),
        Point.new(:a69, 4.5,1.5),
        Point.new(:a70, 3.9,1.1),
        Point.new(:a71, 4.8,1.8),
        Point.new(:a72, 4.0,1.3),
        Point.new(:a73, 4.9,1.5),
        Point.new(:a74, 4.7,1.2),
        Point.new(:a75, 4.3,1.3),
        Point.new(:a76, 4.4,1.4),
        Point.new(:a77, 4.8,1.4),
        Point.new(:a78, 5.0,1.7),
        Point.new(:a79, 4.5,1.5),
        Point.new(:a80, 3.5,1.0),
        Point.new(:a81, 3.8,1.1),
        Point.new(:a82, 3.7,1.0),
        Point.new(:a83, 3.9,1.2),
        Point.new(:a84, 5.1,1.6),
        Point.new(:a85, 4.5,1.5),
        Point.new(:a86, 4.5,1.6),
        Point.new(:a87, 4.7,1.5),
        Point.new(:a88, 4.4,1.3),
        Point.new(:a89, 4.1,1.3),
        Point.new(:a90, 4.0,1.3),
        Point.new(:a91, 4.4,1.2),
        Point.new(:a92, 4.6,1.4),
        Point.new(:a93, 4.0,1.2),
        Point.new(:a94, 3.3,1.0),
        Point.new(:a95, 4.2,1.3),
        Point.new(:a96, 4.2,1.2),
        Point.new(:a97, 4.2,1.3),
        Point.new(:a98, 4.3,1.3),
        Point.new(:a99, 3.0,1.1),
        Point.new(:a100,    4.1,1.3),
        Point.new(:a101,    6.0,2.5),
        Point.new(:a102,    5.1,1.9),
        Point.new(:a103,    5.9,2.1),
        Point.new(:a104,    5.6,1.8),
        Point.new(:a105,    5.8,2.2),
        Point.new(:a106,    6.6,2.1),
        Point.new(:a107,    4.5,1.7),
        Point.new(:a108,    6.3,1.8),
        Point.new(:a109,    5.8,1.8),
        Point.new(:a110,    6.1,2.5),
        Point.new(:a111,    5.1,2.0),
        Point.new(:a112,    5.3,1.9),
        Point.new(:a113,    5.5,2.1),
        Point.new(:a114,    5.0,2.0),
        Point.new(:a115,    5.1,2.4),
        Point.new(:a116,    5.3,2.3),
        Point.new(:a117,    5.5,1.8),
        Point.new(:a118,    6.7,2.2),
        Point.new(:a119,    6.9,2.3),
        Point.new(:a120,    5.0,1.5),
        Point.new(:a121,    5.7,2.3),
        Point.new(:a122,    4.9,2.0),
        Point.new(:a123,    6.7,2.0),
        Point.new(:a124,    4.9,1.8),
        Point.new(:a125,    5.7,2.1),
        Point.new(:a126,    6.0,1.8),
        Point.new(:a127,    4.8,1.8),
        Point.new(:a128,    4.9,1.8),
        Point.new(:a129,    5.6,2.1),
        Point.new(:a130,    5.8,1.6),
        Point.new(:a131,    6.1,1.9),
        Point.new(:a132,    6.4,2.0),
        Point.new(:a133,    5.6,2.2),
        Point.new(:a134,    5.1,1.5),
        Point.new(:a135,    5.6,1.4),
        Point.new(:a136,    6.1,2.3),
        Point.new(:a137,    5.6,2.4),
        Point.new(:a138,    5.5,1.8),
        Point.new(:a139,    4.8,1.8),
        Point.new(:a140,    5.4,2.1),
        Point.new(:a141,    5.6,2.4),
        Point.new(:a142,    5.1,2.3),
        Point.new(:a143,    5.1,1.9),
        Point.new(:a144,    5.9,2.3),
        Point.new(:a145,    5.7,2.5),
        Point.new(:a146,    5.2,2.3),
        Point.new(:a147,    5.0,1.9),
        Point.new(:a148,    5.2,2.0),
        Point.new(:a149,    5.4,2.3),
        Point.new(:a150,    5.1,1.8)
    ]
    r = Random.new
    @centroids = [
        Point.new(:a, r.rand(5-1.4)+1.4, r.rand(1.8-0.2)+0.2),
        Point.new(:b, r.rand(5-1.4)+1.4, r.rand(1.8-0.2)+0.2)
    ]
    @algorithm = Carmenere::KMeans::Algorithm.new(@centroids, @nodes) do |cluster|
        point_mean(cluster)
    end
  end

  def test_run
    puts @algorithm.run
  end

  def test_step
    @algorithm.run do |s|
        s.each { |c| puts c }
    end
  end

end
