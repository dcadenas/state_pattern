require 'test_helper'

module Family
  class James < StatePattern::State
    def name
      transition_to(Lynn)
      "James #{stateable.last_name}"
    end

    def james_method
    end
  end

  class Lynn < StatePattern::State
    def name
      transition_to(James)
      "Lynn #{stateable.last_name}"
    end
  end

  class Member
    include StatePattern
    set_initial_state Lynn
    valid_transitions [James, :name] => Lynn, [Lynn, :name] => James

    #notice this method is optional, it will be delegated automatically if removed
    def name
      delegate_to_state :name
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

  expect true do
    Family::Member.new.respond_to?(:james_method)
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

  expect ["ping", "on", "pong", "off"] do
    with_test_class("PingPong", :states => ["Ping", "Pong"], :initial_state => "Pong", :transitions => {["Ping", :do_it] => "Pong", ["Pong", :do_it] => "Ping"}) do
      with_test_class("Button", :states => ["On", "Off"], :initial_state => "Off", :transitions => {["On", :press] => "Off", ["Off", :press] => "On"}) do
        pingpong = PingPong.new
        button = Button.new
        [pingpong.do_it, button.press, pingpong.do_it, button.press]
      end
    end
  end
end


