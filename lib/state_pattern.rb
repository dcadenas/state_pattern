require 'facets'

module StatePattern
  def self.included(base)
    base.class_eval do
      attr_accessor :state
      def self.add_states(*state_classes)
        state_classes.each do |state_class|
          include state_class
        end
      end

      def self.set_initial_state(state_class)
        @@initial_state = state_class
      end

      def initialize(*args)
        super(*args)
        self.state = @@initial_state
      end

      def state_instance
        as(state)
      end

      def transition_to(state_module)
        self.state = state_module
      end
    end
  end
end


