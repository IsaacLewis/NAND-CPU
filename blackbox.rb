class BlackBox
  def self.new(name,ins,outs,&block)
    klass = Class.new do
      def initialize(*inputs)
        ins, outs, block = [:@@ins, :@@outs, :@@block].map do |sym|
          self.class.class_variable_get(sym)
        end
        if inputs.length != ins
          throw "wrong number of inputs! should be %s not %s" % [ins, inputs.length]
        end
        @inputs = inputs
        @outputs = *(block.call @inputs, @outputs)
        if @outputs.length != outs
          throw "wrong number of outputs! should be %s not %s" % [outs, @outputs.length]
        end
      end

      def [](n)
        throw "invalid output!" if n >= @outputs.length 
        @outputs[n]
      end

      # by default, on of a blackbox is on of first output
      def on(t)
        self[0].on(t)
      end

      def ons(t)
        @outputs.map {|o| o.on(t) ? 1 : 0}
      end
    end

    klass.class_variable_set :@@ins, ins
    klass.class_variable_set :@@outs, outs
    klass.class_variable_set :@@block, block
    Kernel.const_set name, klass
    Kernel.send :define_method, name, proc {|*args| Kernel.const_get(name).new(*args)}
  end
end
