require 'test_helper'

module Querying
  class StateBaseBase < StatePattern::State
    def common_event
    end
  end

  class StateBase < StateBaseBase
    def another_common_event
    end
  end

  class On < StateBase
    def press
      transition_to(Off)
    end

    def one_event
    end

    def another_event
    end

    def enter
    end

    def exit
    end
  private
    def not_an_event
    end
  end

  class Off < StateBase
    def press
      transition_to(On)
    end

    def one_event
    end

    def another_event
    end
  end

  class Button
    include StatePattern
    set_initial_state On
    valid_transitions [On, :press] => Off, [Off, :press] => On
  end
end

Expectations do
  expect %w(Querying::Off Querying::On) do
    Querying::Button.state_classes.map{|c| c.name}.sort
  end

  expect ["another_common_event", "another_event", "common_event", "one_event", "press"] do
    Querying::Button.state_methods.map{|s| s.to_s}.sort
  end

  expect [:press] do
    Querying::Button.state_events
  end

  expect true do
    Querying::Button.new.on?
  end

  expect false do
    Querying::Button.new.off?
  end

  expect false do
    button = Querying::Button.new
    button.press
    button.on?
  end

  expect true do
    button = Querying::Button.new
    button.press
    button.off?
  end
end

