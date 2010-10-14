module StatePattern
  class State
    attr_reader :stateable, :previous_state
    def initialize(stateable, previous_state)
      @stateable = stateable
      @previous_state = previous_state
      enter
    end

    def self.state_methods
      public_instance_methods - State.public_instance_methods
    end

    def transition_to(state_class)
      @stateable.transition_to(state_class)
    end

    def enter
    end

    def exit
    end
  end
end
