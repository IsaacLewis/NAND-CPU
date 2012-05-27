

# TruthTable for maximal 2**4 States
class TruthTable

  attr_accessor :states

  def initialize( states_count )
    @states = generate_states( states_count)
  end

  def generate_states( count )
    ary = Array.new

    factor = 2
    count.times do

      new = Array.new
      until new.length == ( 2**count )
        t = count**2 / factor
        t.times do new << false end
        t.times do new << true end
      end
      
      ary << new
      factor *= 2
    end
    ary
  end

  def to_s
    0.upto @states.first.length-1 do |i|
      @states.each do |ary|
        bit = ary[i] ? 1.to_s : 0.to_s
        print bit + " "
      end
      print $/
    end
  end

end
