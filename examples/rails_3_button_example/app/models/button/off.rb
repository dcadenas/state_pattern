class Button::Off < StatePattern::State
  def push!
    transition_to(Button::On)
    stateful.save!
    "I am turned on :)"
  end
end
