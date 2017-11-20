require_relative 'check'

class SampleClass
  include TypeCheck

  def initialize(msg, number)
    type_check(String: msg, Integer: number)
  end

  def some_method()
    tc_
  end

end

sc = SampleClass.new("hello world", "12")

