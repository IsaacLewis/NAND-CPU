class NAND
  attr_accessor :l, :r
  def initialize(l,r)
    @l,@r = l,r
  end

  def on(t)
    t < 0 ? false : !(@l.on(t) && @r.on(t))
  end
end

def n(l,r)
  NAND.new l,r
end

# Wire - output at time t is equal to input at time (t-1). Needed to make flip-flops work properly.
class Wire
  def initialize(i)
    @i = i
  end

  def on(t)
    @i.on(t-1)
  end
end

def w(i)
  Wire.new i
end

class Integer
  def on(t)
    case self
    when 0 then false
    when 1 then true
    else fail
    end
  end
end

# A class for providing test inputs. Outputs on at times specified by on_ranges. 
# Eg, Test.new 0..2, 5..6 will be ON at times 0,1,2,5 and 6, and OFF at times 3,4,7+.
class TestInput
  def initialize(*on_ranges)
    @on_ranges = on_ranges
  end

  def on(t)
    !!@on_ranges.find {|r| r.include? t}
  end
end

def t(*on_ranges)
  TestInput.new *on_ranges
end

class Nil
  def on(t)
    false
  end
end
