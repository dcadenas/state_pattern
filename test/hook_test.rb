require 'test_helper'

module Hooks
  class On < StatePattern::State
    def press
      transition_to(Off)
      stateful.messages << "#{stateful.button_name} is off"
    end

    def enter
      stateful.messages << "Entered the On state"
    end

    def exit
      stateful.messages << "Exited the On state"
    end

  private 
    def private_method
    end
  end

  class Off < StatePattern::State
    def press
      transition_to(On)
      stateful.messages << "#{stateful.button_name} is on"
    end

    def enter
      stateful.messages << "Entered the Off state"
    end

    def exit
      stateful.messages << "Exited the Off state"
    end
  end

  class Button
    include StatePattern
    set_initial_state Off

    def button_name
      "Button"
    end

    def messages
      @messages ||= []
    end
  end
end

Expectations do
  expect ["Entered the Off state", "Exited the Off state", "Entered the On state", "Button is on"] do
    button = Hooks::Button.new
    button.press
    button.messages
  end

  expect ["Entered the Off state", "Exited the Off state", "Entered the On state", "Button is on", "Exited the On state", "Entered the Off state", "Button is off"] do
    button = Hooks::Button.new
    button.press
    button.press
    button.messages
  end

  expect false do
    Hooks::Button.new.respond_to?(:enter)
  end

  expect false do
    Hooks::Button.new.respond_to?(:exit)
  end

  expect false do
    Hooks::Button.new.respond_to?(:private_method)
  end

  expect true do
    Hooks::Button.new.respond_to?(:press)
  end
end

