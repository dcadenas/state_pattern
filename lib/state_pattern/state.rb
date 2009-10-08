module StatePattern
  class State
    attr_reader :stateable, :previous_state
    def initialize(stateable, previous_state)
      @stateable = stateable
      @previous_state = previous_state
    end

    def transition_to(state_class)
      @stateable.transition_to(state_class)
    end
  end
end
