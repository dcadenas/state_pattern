module StatePattern
  class State
    attr_reader :stateable
    def initialize(stateable)
      @stateable = stateable
    end

    def transition_to(state_class)
      @stateable.transition_to(state_class)
    end

    def state
      self.class.to_s
    end
  end
end
