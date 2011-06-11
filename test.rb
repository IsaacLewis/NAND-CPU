require 'test/unit'
load 'blackboxes.rb'

class ComponentTest < Test::Unit::TestCase
  def test_and
    assert_equal false, AND(0,0).on(0)
    assert_equal false, AND(0,1).on(0)
    assert_equal false, AND(1,0).on(0)
    assert_equal true, AND(1,1).on(0)
  end

  
  def test_not
    assert_equal false, NOT(1).on(0)
    assert_equal true, NOT(0).on(0)
  end

  def test_yes
    assert_equal true, YES(1).on(0)
    assert_equal false, YES(0).on(0)
  end

  def test_or
    assert_equal false, OR(0,0).on(0)
    assert_equal true, OR(0,1).on(0)
    assert_equal true, OR(1,0).on(0)
    assert_equal true, OR(1,1).on(0)
  end

  def test_xor
    assert_equal false, XOR(0,0).on(0)
    assert_equal true, XOR(0,1).on(0)
    assert_equal true, XOR(1,0).on(0)
    assert_equal false, XOR(1,1).on(0)
  end
  
  def test_clock
    c = Clock.new
    assert_equal true, c.on(0)
    assert_equal false, c.on(1)
    assert_equal true, c.on(2)
    assert_equal false, c.on(3)
    assert_equal true, c.on(4)
  end

end
