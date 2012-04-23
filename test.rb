require 'test/unit'
load 'blackboxes.rb'

class ComponentTest < Test::Unit::TestCase
  def test_and
    assert !AND(0,0).on(0)
    assert !AND(0,1).on(0)
    assert !AND(1,0).on(0)
    assert AND(1,1).on(0)
  end

  
  def test_not
    assert !NOT(1).on(0)
    assert NOT(0).on(0)
  end

  def test_yes
    assert YES(1).on(0)
    assert !YES(0).on(0)
  end

  def test_or
    assert !OR(0,0).on(0)
    assert OR(0,1).on(0)
    assert OR(1,0).on(0)
    assert OR(1,1).on(0)
  end

  def test_xor
    assert !XOR(0,0).on(0)
    assert XOR(0,1).on(0)
    assert XOR(1,0).on(0)
    assert !XOR(1,1).on(0)
  end
  
  def test_clock
    c = Clock.new
    assert c.on(0)
    assert !c.on(1)
    assert c.on(2)
    assert !c.on(3)
    assert c.on(4)
  end

  def test_dlatch
    d = DLatch(t(3..10),t(0..1, 8..10))
    assert !d.on(1)
    assert !d.on(2)
    assert !d.on(3)
    assert !d.on(4)
    assert !d.on(5)
    assert !d.on(6)
    assert !d.on(7)
    assert d.on(8)
    assert d.on(9)
    assert d.on(10)
  end

  def test_multiplexer
    assert !Multiplexer(0,0,0).on(0)
    assert Multiplexer(0,1,0).on(0)
    assert !Multiplexer(1,0,0).on(0)
    assert Multiplexer(1,0,1).on(0)    
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
