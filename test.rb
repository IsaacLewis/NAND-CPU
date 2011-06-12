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

  def test_dlatch
    d = DLatch(t(3..10),t(0..1, 8..10))
    assert_equal false, d.on(1)
    assert_equal false, d.on(2)
    assert_equal false, d.on(3)
    assert_equal false, d.on(4)
    assert_equal false, d.on(5)
    assert_equal false, d.on(6)
    assert_equal false, d.on(7)
    assert_equal true, d.on(8)
    assert_equal true, d.on(9)
    assert_equal true, d.on(10)
  end

  def test_multiplexer
    assert_equal false, Multiplexer(0,0,0).on(0)
    assert_equal true, Multiplexer(0,1,0).on(0)
    assert_equal false, Multiplexer(1,0,0).on(0)
    assert_equal true, Multiplexer(1,0,1).on(0)    
  end

  def test_caching
    d = DLatch(1,0)
    t1 = Time.new
    d.on 10000
    first_run = Time.new - t1
    t2 = Time.new
    d.on 10000
    second_run = Time.new - t2
    puts "without caching: #{first_run} with caching: #{second_run}"
    assert first_run > second_run
    assert first_run > (second_run * 1000)
  end
end
