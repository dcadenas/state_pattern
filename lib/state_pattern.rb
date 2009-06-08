require 'state_pattern/state'
require 'state_pattern/invalid_transition_exception'

module StatePattern
  def self.included(base)
    base.instance_eval do
      def state_classes
        @state_classes ||= []
      end

      def initial_state_class
        @initial_state_class
      end

      def set_initial_state(state_class)
        @initial_state_class = state_class
      end

      def add_states(*state_classes)
        state_classes.each do |state_class|
          add_state_class(state_class)
        end
      end

      def add_state_class(state_class)
        state_classes << state_class
      end

      def valid_transitions(transitions_hash)
        @transitions_hash = transitions_hash
      end

      def transitions_hash
        @transitions_hash
      end

      def delegate_all_state_events
        state_methods.each do |state_method|
          define_method state_method do |*args|
            delegate_to_event(state_method)
          end
        end
      end

      def state_methods
        state_classes.map{|state_class| state_class.public_instance_methods(false)}.flatten.uniq
      end
    end
  end

  attr_accessor :current_state, :current_event, :states
  def initialize(*args)
    super(*args)
    self.states = {}
    add_state_instances
    set_state(self.class.initial_state_class)
    self.class.delegate_all_state_events
  end

  def set_state(state_class)
    add_state_instance(state_class)
    self.current_state = self.states[state_class]
  end

  def add_state_instances
    self.class.state_classes.map do |state_class|
      add_state_instance(state_class)
    end
  end
  
  def add_state_instance(state_class)
    self.states[state_class] = state_class.new(self) if !self.states.has_key?(state_class) || self.states[state_class].nil?
  end

  def delegate_to_event(method_name, *args)
    self.current_event = method_name.to_sym
    self.current_state.send(current_event, *args)
  end

  def transition_to(state_class)
    raise InvalidTransitionException.new(self.current_state.class, state_class, self.current_event) unless self.valid_transition?(self.current_state.class, state_class)
    set_state(state_class)
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
    self.current_state.state
  end
end


