
require 'ScreenReader.rb'


class BPProxy
  def complete(val)
    puts "COMPLETE:"
    printer(val)
  end
end

class Invoker
  def invoke(val)
    puts "CALLBACK:"
    printer(val)
  end
end

bp = BPProxy.new
reader = ScreenReader.new([])

puts reader.detect(bp, {})

