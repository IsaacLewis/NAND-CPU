TRUE_STATE  = 1
FALSE_STATE = 0

# TruthTable for maximal 2**4 States, (MemoryError when 2**5 on my machine)
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
        t = 1 if t == 0
        t.times do new << FALSE_STATE end
        t.times do new << TRUE_STATE end
      end
      
      ary << new
      factor *= 2
    end
    ary
  end

  def to_s
    0.upto @states.first.length-1 do |i|
      @states.each do |ary|
        print ary[i].to_s + " "
      end
      print $/
    end
  end

  # overwrite attr_reader
  def states
    all_states = Array.new
    0.upto @states.first.length - 1 do |i|
      ary = Array.new
      @states.each do |state|
        ary << state[i]
      end
      all_states << ary
    end
    all_states
  end

  def each_state &block
    states.each &block
  end

  def each_state_with_index &block
    states.each_with_index &block
  end

  def each_state_with_object &block
    states.each_with_object &block
  end

end

require 'test/unit'
load 'blackboxes.rb'

class TruthTableTest < Test::Unit::TestCase

  def test_and
    should = [ false, false, false, true ]
    do_test should, 2, :AND 
  end

  def test_not
    should = [ true, false ]
    do_test should, 1, :NOT
  end

  def test_yes
    should = [ false, true ]
    do_test should, 1, :YES
  end 

  def test_or
    should = [ false, true, true, true ]
    do_test should, 2, :OR
  end

  def test_xor
    should = [ false, true, true, false ]
    do_test should, 2, :XOR
  end

  def do_test( should, tt_len, box_sym )
    TruthTable.new( tt_len ).each_state_with_index do |state, i|
      assert_equal( should[i], Kernel.send( box_sym, *state ).on(0) )
    end
  end
end
