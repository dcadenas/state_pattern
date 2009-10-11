require 'state_pattern/state'
require 'state_pattern/invalid_transition_exception'

module StatePattern
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def initial_state_class
      @initial_state_class
    end

    def set_initial_state(state_class)
      @initial_state_class = state_class
      delegate_all_state_events
    end

    def delegate_all_state_events
      state_events.each do |state_event|
        define_method state_event do |*args|
          delegate_to_event(state_event, *args)
        end
      end
    end

    def state_events
      state_classes.map{|state_class| state_class.public_instance_methods(false)}.flatten.uniq - ["enter", "exit"]
    end

    def state_classes
      (transitions_hash.to_a << initial_state_class).flatten.uniq.select{|t| t.respond_to?(:ancestors) && t.ancestors.include?(StatePattern::State)}
    end

    def valid_transitions(transitions_hash)
      @transitions_hash = transitions_hash
      @transitions_hash.each do |key, value|
        @transitions_hash[key] = [value] if !value.respond_to?(:to_ary)
      end
    end

    def transitions_hash
      @transitions_hash
    end
  end

  def set_state(state_class = nil)
    state_class ||= self.class.initial_state_class
    return @current_state_instance if @current_state_instance.class == state_class
    @current_state_instance = state_class.new(self, @current_state_instance)
  end
    
  def current_state_instance
    set_state if @current_state_instance.nil?
    @current_state_instance
  end

  def delegate_to_event(event_method_name, *args, &block)
    @current_event = event_method_name.to_sym
    self.current_state_instance.send(@current_event, *args, &block)
  end

  def transition_to(next_state_class)
    raise_invalid_transition_to(next_state_class) unless valid_transition?(current_state_instance.class, next_state_class)
    current_state_instance.exit
    set_state(next_state_class)
  end

  def raise_invalid_transition_to(state_class)
    raise InvalidTransitionException.new(current_state_instance.class, state_class, @current_event)
  end

  def valid_transition?(from_state, to_state)
    transitions = self.class.transitions_hash
    return true if transitions.nil?

    valid_transition_targets = transitions[from_state] || transitions[[from_state, @current_event]]
    valid_transition_targets && valid_transition_targets.include?(to_state)
  end
end
