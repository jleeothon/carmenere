require 'minitest/autorun'

require 'medjool'

require 'flag'

require 'minitest/pride'

class TestFlagCluster < MiniTest::Unit::TestCase

  def setup
    @flags = Flag::load 'test/flag.json'
  end

  def test_10_clusters
    @algorithm = Medjool::SingleLinkage::Algorithm.new 10, @flags
    puts @algorithm.run
  end

end
