class Button::Off < StatePattern::State
  def push!
    transition_to(Button::On)
    stateable.save!
    "I am turned on :)"
  end
end
