require 'test_helper'

module Family
  module James
    protected
    def name
      transition_to(Lynn)
      "James #{last_name}"
    end
  end

  module Lynn
    protected
    def name
      transition_to(James)
      "Lynn #{last_name}"
    end
  end

  class Member
    include StatePattern
    add_states James, Lynn
    set_initial_state Lynn
    valid_transitions [James, :name] => Lynn, [Lynn, :name] => James

    #notice this method is optional, it will be delegated automatically if removed
    def name
      delegate_to_event :name
    end

    def last_name
      "Holbrook"
    end
  end
end

Expectations do
  expect "Lynn Holbrook" do
    member = Family::Member.new
    member.name 
  end

  expect "James Holbrook" do
    member = Family::Member.new
    member.name 
    member.name 
  end

  expect "Lynn Holbrook" do
    member = Family::Member.new
    member.name 
    member.name 
    member.name 
  end

  expect "on" do
    with_test_class("Button", :states => ["On", "Off"], :initial_state => "Off",
                    :transitions => {["On", :press] => "Off", ["Off", :press] => "On"}) do
      button = Button.new
      button.press
    end
  end

  expect "off" do
    with_test_class("Button", :states => ["On", "Off"], :initial_state => "Off",
                    :transitions => {["On", :press] => "Off", ["Off", :press] => "On"}) do
      button = Button.new
      button.press
      button.press
    end
  end

  expect "on" do
    with_test_class("Button", :states => ["On", "Off"], :initial_state => "Off",
                    :transitions => {["On", :press] => "Off", ["Off", :press] => "On"}) do
      button = Button.new
      button.press
      button.press
      button.press
    end
  end

  expect "on" do
    with_test_class("Button", :states => ["On", "Off"], :initial_state => "Off",
                    :transitions => {["On", :press] => "Off", ["Off", :press] => "On"}) do
      button1 = Button.new
      button2 = Button.new
      button1.press
      button2.press
    end
  end
end


