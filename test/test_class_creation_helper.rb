module TestClassCreationHelper
  #TODO: ugly
  def with_test_class(main_state_module_name, options = {})
    created_consts = []
    transitions = options[:transitions] || {}
    state_methods = transitions.keys.map{|t| t.last}.uniq || []

    if options.has_key?(:states)
      options[:states].each do |state_name|
        created_consts << create_class(state_name, StatePattern::State) do
          state_methods.each do |method_name|
            define_method method_name do
              next_state_name = transitions[[state_name, method_name]]
              next_state_module = next_state_name && Object.const_get(next_state_name)
              transition_to next_state_module
              next_state_name.downcase
            end
          end
        end
      end
    end

    created_consts << create_class(main_state_module_name) do
      include StatePattern
      set_initial_state Object.const_get(options[:initial_state]) if options.has_key?(:initial_state)
      if options.has_key?(:valid_transitions)
        valid_transitions_with_constants = {}
        options[:valid_transitions].each do |from_module_string_or_array, to_module_string|
          if from_module_string_or_array.respond_to?(:to_ary)
            valid_transitions_with_constants[[Object.const_get(from_module_string_or_array.first), from_module_string_or_array.last]] = Object.const_get(to_module_string)
          else
            valid_transitions_with_constants[Object.const_get(from_module_string_or_array)] = Object.const_get(to_module_string)
          end
        end
        valid_transitions valid_transitions_with_constants
      end
    end

    begin
      yield
    ensure 
      created_consts.compact.each do |created_const|
        Object.send(:remove_const, created_const.to_s.to_sym)
      end
    end
  end

private

  def create_module(module_name, superklass = Object, module_or_class = Module, &block)
    new_module = module_or_class.new(superklass, &block)
    Object.const_set(module_name, new_module) unless Object.const_defined? module_name
  end

  def create_class(class_name, superklass = Object, &block)
    create_module(class_name, superklass, Class, &block)
  end
end
