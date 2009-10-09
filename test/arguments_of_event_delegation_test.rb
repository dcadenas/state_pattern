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

=begin
  PENDING
  Currently using class_eval to define the delegation method (so we can pass a block)
  is causing a segmention fault on 1.8.6 so we only use define_method to do the delegation
  if you want to pass a block do so as a normal variable, do use yield

  expect "state event args == arg1, arg2, arg3" do
    sample_class_instance = ::SampleClassWithStatePattern.new
    sample_class_instance.event("arg1", "arg2"){"arg3"}
  end
=end
end
