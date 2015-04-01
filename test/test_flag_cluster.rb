require 'minitest/autorun'

require 'medjool'

require 'flag'

require 'minitest/pride'

class TestFlagCluster < MiniTest::Unit::TestCase

  def setup
    @flags = Flag::load 'test/flag.json'
  end

  def test_10_clusters
    @algorithm = SingleLinkage::Algorithm.new 10, @flags
    @algorithm.run do |clusters|
        puts clusters.to_s
        puts '--------------------------------------------------------------------------------'
    end
  end

end
