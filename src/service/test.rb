
require 'ScreenReader.rb'
require 'pp'

class BPProxy
  def complete(val)
    puts "COMPLETE:"
    printer(val)
  end
end

class Invoker
  def invoke(val)
    puts "CALLBACK:"
    pp val
  end
end

bp = BPProxy.new
reader = ScreenReader.new([])

invoker = Invoker.new

reader.detect(bp, { 'callback' => invoker})

