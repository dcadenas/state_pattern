module StatePattern
  class InvalidTransitionException < RuntimeError
    attr_reader :from_module, :to_module, :event
    def initialize(from_module, to_module, event)
      @from_module = from_module
      @to_module = to_module
      @event = event
    end

    def message
      "Event #@event cannot transition from #@from_module to #@to_module"
    end
  end
end
