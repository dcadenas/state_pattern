class Button::On < StatePattern::State
  def push!
    transition_to(Button::Off)
    stateful.save!
    "I am turned off :("
  end
end

