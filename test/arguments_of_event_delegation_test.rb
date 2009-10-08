require 'test_helper'

class SampleClass
  def event(arg1, arg2)
    block_value = block_given? ? yield : nil
    [arg1, arg2, block_value].compact.join(", ")
  end
end

class SampleState < StatePattern::State
  def event(arg1, arg2)
    block_value = block_given? ? yield : nil
    "state event args == " + [arg1, arg2, block_value].compact.join(", ")
  end
end

class SampleClassWithStatePattern < SampleClass
  include StatePattern
  set_initial_state SampleState
end

Expectations do
  expect "arg1, arg2" do
    sample_class_instance = ::SampleClass.new
    sample_class_instance.event("arg1", "arg2")
  end

  expect "state event args == arg1, arg2" do
    sample_class_instance = ::SampleClassWithStatePattern.new
    sample_class_instance.event("arg1", "arg2")
  end
end
