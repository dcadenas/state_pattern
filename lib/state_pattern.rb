require 'state_pattern/state'
require 'state_pattern/invalid_transition_exception'

module StatePattern
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def state_classes
      state_classes_in_transisions_hash = []

      if transitions_hash
        state_classes_in_transisions_hash = transitions_hash.map do |from, to|
          from_class = from.respond_to?(:to_ary) ? from.first : from
          to_classes = to.respond_to?(:to_ary) ? to : [to]
          to_classes + [from_class]
        end.flatten
      end

      state_classes_in_transisions_hash << initial_state_class
      state_classes_in_transisions_hash.uniq
    end

    def initial_state_class
      @initial_state_class
    end

    def set_initial_state(state_class)
      @initial_state_class = state_class
      delegate_all_state_events
    end

    def valid_transitions(transitions_hash)
      @transitions_hash = transitions_hash
      @transitions_hash.each do |key, value|
        if !value.respond_to?(:to_ary)
          @transitions_hash[key] = [value]
        end
      end
    end

    def transitions_hash
      @transitions_hash
    end

    def delegate_all_state_events
      state_methods.each do |state_method|
        define_method state_method do |*args|
          delegate_to_event(state_method, *args)
        end
      end
    end

    def state_methods
      state_classes.map{|state_class| state_class.public_instance_methods(false)}.flatten.uniq
    end
  end

  def set_state(state_class = self.class.initial_state_class)
    @current_state_instance = state_class.new(self, @current_state_instance)
  end

  def current_state_instance
    set_state if @current_state_instance.nil?
    @current_state_instance
  end

  def delegate_to_event(method_name, *args, &block)
    @current_event = method_name.to_sym
    self.current_state_instance.send(@current_event, *args, &block)
  end

  def transition_to(state_class)
    raise InvalidTransitionException.new(current_state_instance.class, state_class, @current_event) unless valid_transition?(current_state_instance.class, state_class)
    set_state(state_class)
  end

  def valid_transition?(from_module, to_module)
    trans = self.class.transitions_hash
    return true if trans.nil?

    valid_transition_targets = trans[from_module] || trans[[from_module, @current_event]]
    valid_transition_targets && valid_transition_targets.include?(to_module)
  end
end


