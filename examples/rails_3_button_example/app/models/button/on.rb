class Button::On < StatePattern::State
  def push!
    transition_to(Button::Off)
    stateable.save!
    "I am turned off :("
  end
end

