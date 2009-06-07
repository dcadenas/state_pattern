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

    def name
      state_instance.name
    end

    def last_name
      "Holbrook"
    end
  end
end

module Button
  module On
    def press
      transition_to Off
      "off"
    end
  end

  module Off
    def press
      transition_to On
      "on"
    end
  end

  class Button
    include StatePattern
    add_states On, Off
    set_initial_state Off

    def press
      state_instance.press
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

  expect ["Lynn Holbrook", "on", "James Holbrook", "off"] do
    button = Button::Button.new
    member = Family::Member.new
    [member.name, button.press, member.name, button.press]
  end
end


