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
      create_methods
    end

    def state_methods
      state_classes_with_their_bases = state_classes.map{|c| c.ancestors.select{|a| a.ancestors.include?(StatePattern::State) && a != StatePattern::State}}.flatten.uniq
      (state_classes_with_their_bases.map{|state_class| state_class.public_instance_methods(false)}.flatten.uniq - ["enter", "exit"]).map{|s| s.to_sym}
    end

    def state_events
      transitions_hash.to_a.flatten.uniq.select{|t| t.respond_to?(:to_sym)}.map{|s| s.to_sym}
    end

    def state_classes
      (transitions_hash.to_a << initial_state_class).flatten.uniq.select{|t| t.respond_to?(:ancestors) && t.ancestors.include?(StatePattern::State)}
    end

    def valid_transitions(transitions_hash)
      @transitions_hash = transitions_hash
      @transitions_hash.each do |key, value|
        @transitions_hash[key] = [value] if !value.respond_to?(:to_ary)
      end
      create_methods
    end

    def transitions_hash
      @transitions_hash
    end

  private
    def create_methods
      delegate_all_state_methods
      create_query_methods
    end

    def delegate_all_state_methods
      state_methods.each do |state_method|
        define_method state_method do |*args|
          delegate_to_state(state_method, *args)
        end unless respond_to?(state_method)
      end
    end

    def create_query_methods
      state_classes.each do |state_class|
        method_name = "#{underscore(state_class.name.split("::").last)}?"
        define_method method_name do
          current_state_instance.class == state_class
        end unless respond_to?(method_name)
      end
    end

    def underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/\W/, "_")
      camel_cased_word.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
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

  def delegate_to_state(state_method_name, *args, &block)
    @current_method = state_method_name.to_sym
    self.current_state_instance.send(@current_method, *args, &block)
  end

  def transition_to(next_state_class)
    raise_invalid_transition_to(next_state_class) unless valid_transition?(current_state_instance.class, next_state_class)
    current_state_instance.exit
    set_state(next_state_class)
  end

  def raise_invalid_transition_to(state_class)
    raise InvalidTransitionException.new(current_state_instance.class, state_class, @current_method)
  end

  def valid_transition?(from_state, to_state)
    transitions = self.class.transitions_hash
    return true if transitions.nil?

    valid_transition_targets = transitions[from_state] || transitions[[from_state, @current_method]]
    valid_transition_targets && valid_transition_targets.include?(to_state)
  end
end
