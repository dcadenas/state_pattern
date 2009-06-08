require 'facets'

module StatePattern
  class InvalidTransitionException < RuntimeError
    attr_reader :from_module, :to_module
    def initialize(from_module, to_module)
      @from_module = from_module
      @to_module = to_module
    end

    def message
      "Cannot transition from #{@from_module} to #{@to_module}"
    end
  end

  def self.included(base)
    base.instance_eval do
      def initial_state
        @initial_state
      end

      def set_initial_state(state_module)
        @initial_state = state_module
      end

      def add_states(*state_modules)
        @state_modules = state_modules
        @state_modules.each do |state_module|
          include state_module
        end
        delegate_all_events
      end

      def valid_transitions(transitions_hash)
        @transitions_hash = transitions_hash
      end

      def transitions_hash
        @transitions_hash
      end

      def delegate_all_events
        state_methods.each do |method_name|
          define_method method_name do |*args|
            delegate_to_event(method_name, *args)
          end
        end
      end

      def state_methods
        @state_modules.map{|state_module| state_module.__send__(:instance_methods)}.flatten.uniq
      end
    end
  end

  attr_accessor :current_state_module, :current_event
  def initialize(*args)
    super(*args)
    self.current_state_module = self.class.initial_state
  end

  def current_state_instance
    as(current_state_module)
  end

  def transition_to(state_module)
    raise InvalidTransitionException.new(self.current_state_module, state_module) unless self.valid_transition?(self.current_state_module, state_module)
    self.current_state_module = state_module
  end

  def valid_transition?(from_module, to_module)
    trans = self.class.transitions_hash
    return true if trans.nil?
    
    #TODO: ugly
    trans.has_key?(from_module) &&
      (trans[from_module] == to_module ||
       trans[from_module].include?(to_module)) ||
     trans.has_key?([from_module, current_event]) &&
     (trans[[from_module, current_event]] == to_module || trans[[from_module, current_event]].include?(to_module))
  end

  def state
    self.current_state_module.to_s
  end

  def delegate_to_event(method_name, *args)
    self.current_event = method_name.to_sym
    self.current_state_instance.__send__(current_event, *args)
  end
end


