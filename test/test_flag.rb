require 'minitest/autorun'

require 'carmenere'

require 'flag'

class TestFlag < Minitest::Test

  def setup
    @flags = Flag::load 'test/flag.json'
  end

  def test_country_name
    assert_equal 'Afghanistan', @flags[0].name
  end

  def test_bahamas_main_hue
    assert_equal 'blue', @flags[17].attributes[:mainhue]
  end

  def test_nepal_main_hue
    assert_equal 'brown', @flags[120].attributes[:mainhue]
  end

  # ["USA",1,4,9363,231,1,1,0,13,3,1,0,1,0,1,0,0,"white",0,0,0,1,50,0,0,0,0,0,"blue","red"],
  # ["UK",3,4,245,56,1,1,0,0,3,1,0,1,0,1,0,0,"red",0,1,1,0,0,0,0,0,0,0,"white","red"],
  def test_distance_US_UK
    d = @flags[183].distance(@flags[180])
    # puts "US-UK = #{d}"
  end

  # ["Brazil",2,3,8512,119,6,0,0,0,4,0,1,1,1,1,0,0,"green",1,0,0,0,22,0,0,0,0,1,"green","green"],
  # ["UK",3,4,245,56,1,1,0,0,3,1,0,1,0,1,0,0,"red",0,1,1,0,0,0,0,0,0,0,"white","red"],
  def test_distance_Brazil_UK
    d = @flags[23].distance(@flags[180])
    # puts "Brazil-UK = #{d}"
  end

  # ["Colombia",2,4,1139,28,2,0,0,3,3,1,0,1,1,0,0,0,"gold",0,0,0,0,0,0,0,0,0,0,"gold","red"],
  # ["Ecuador" ,2,3,284,8,2,0,0,3,3,1,0,1,1,0,0,0,"gold",0,0,0,0,0,0,0,0,0,0,"gold","red"],
  def test_distance_Colombia_Ecuador
    d = @flags[38].distance(@flags[50])
    # puts "Colombia-Ecuador = #{d}"
  end

  # ["Netherlands",3,1,41,14,6,1,0,3,3,1,0,1,0,1,0,0,"red",0,0,0,0,0,0,0,0,0,0,"red","blue"],
  # ["Ecuador" ,2,3,284,8,2,0,0,3,3,1,0,1,1,0,0,0,"gold",0,0,0,0,0,0,0,0,0,0,"gold","red"],
  def test_distance_TheNetherlands_Ecuador
    d = @flags[121].distance(@flags[50])
    # puts "TheNetherlands-Ecuador = #{d}"
  end

  # ["Luxembourg",3,1,3,0,4,0,0,3,3,1,0,1,0,1,0,0,"red",0,0,0,0,0,0,0,0,0,0,"red","blue"],
  # ["Ecuador" ,2,3,284,8,2,0,0,3,3,1,0,1,1,0,0,0,"gold",0,0,0,0,0,0,0,0,0,0,"gold","red"],
  def test_distance_Luxembourg_Ecuador
    d = @flags[102].distance(@flags[50])
    # puts "Luxembourg-Ecuador = #{d}"
  end

  # ["Luxembourg",3,1,3,0,4,0,0,3,3,1,0,1,0,1,0,0,"red",0,0,0,0,0,0,0,0,0,0,"red","blue"],
  # ["Netherlands",3,1,41,14,6,1,0,3,3,1,0,1,0,1,0,0,"red",0,0,0,0,0,0,0,0,0,0,"red","blue"],
  def test_distance_Luxembourg_TheNetherlands
    d = @flags[102].distance(@flags[121])
    # puts "Luxembourg-TheNetherlands = #{d}"
  end

  # ["UK",3,4,245,56,1,1,0,0,3,1,0,1,0,1,0,0,"red",0,1,1,0,0,0,0,0,0,0,"white","red"],
  # ["Australia",6,2,7690,15,1,1,0,0,3,1,0,1,0,1,0,0,"blue",0,1,1,1,6,0,0,0,0,0,"white","blue"],
  def test_distance_UK_Australia
    d = @flags[180].distance(@flags[10])
    # puts "UK-Australia = #{d}"
  end

end
