require 'facets'

module StatePattern
  def self.included(base)
    base.instance_eval do
      def initial_state
        @initial_state
      end

      def set_initial_state(state_class)
        @initial_state = state_class
      end

      def add_states(*state_classes)
        state_classes.each do |state_class|
          include state_class
        end
      end
    end

    attr_accessor :state
    def initialize(*args)
      super(*args)
      self.state = self.class.initial_state
    end

    def state_instance
      as(state)
    end

    def transition_to(state_module)
      self.state = state_module
    end
  end
end


