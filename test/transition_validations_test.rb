require 'test_helper'

Expectations do
  expect "up" do
    with_test_class("Switch", :states => ["Up", "Down", "Middle"], :initial_state => "Middle",
                    :transitions => {["Up", :push_down] => "Middle",
                      ["Down", :push_up] => "Middle",
                      ["Middle", :push_up] => "Up",
                      ["Middle", :push_down] => "Down"}) do
      switch = Switch.new
      switch.push_up
    end
  end

  expect "up" do
    with_test_class("Switch", :states => ["Up", "Down", "Middle"], :initial_state => "Middle",
                    :transitions => {["Up", :push_down] => "Middle",
                      ["Down", :push_up] => "Middle",
                      ["Middle", :push_up] => "Up",
                      ["Middle", :push_down] => "Down"},
                    :valid_transitions => {["Up", :push_down] => "Middle",
                      ["Down", :push_up] => "Middle",
                      ["Middle", :push_up] => "Up",
                      ["Middle", :push_down] => "Down"}) do
      switch = Switch.new
      switch.push_up
    end
  end

  expect StatePattern::InvalidTransitionException do
    with_test_class("Switch", :states => ["Up", "Down", "Middle"], :initial_state => "Middle",
                    :transitions => {["Up", :push_down] => "Middle",
                      ["Down", :push_up] => "Middle",
                      ["Middle", :push_up] => "Up",
                      ["Middle", :push_down] => "Down"},
                    :valid_transitions => {["Up", :push_down] => "Middle",
                      ["Down", :push_up] => "Middle",
                      ["Middle", :push_down] => "Down"}) do
      switch = Switch.new
      switch.push_up
    end
  end

  expect StatePattern::InvalidTransitionException do
    with_test_class("Switch", :states => ["Up", "Down", "Middle"], :initial_state => "Middle",
                    :transitions => {["Up", :push_down] => "Middle",
                      ["Down", :push_up] => "Middle",
                      ["Middle", :push_up] => "Up",
                      ["Middle", :push_down] => "Down"},
                    :valid_transitions => {"Up" => "Middle", "Down" => "Middle", "Middle" => "Down"}) do
      switch = Switch.new
      switch.push_up
    end
  end
end
