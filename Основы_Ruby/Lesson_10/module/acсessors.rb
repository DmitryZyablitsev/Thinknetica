module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_reader_with_history(*names)
      names.each do |name|
        define_method(name) { instance_variable_get("@#{name}") }
      end
    end

    def attr_writer_with_history(*names)
      names.each do |name|
        define_method("#{name}=") do |variable|
          instance_variable_set("@#{name}", variable)
          history_var_name = "@#{name}_history".to_sym
          history_var_value = instance_variable_get(history_var_name)
          add_or_init_history_value(history_var_value, history_var_name,
                                    variable, name)
        end
      end
    end

    def attr_accessor_with_history(*names)
      attr_writer_with_history(*names)
      attr_reader_with_history(*names)
    end

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        raise "Error, value (#{value}) class is not #{class_name}" if value.class != class_name

        instance_variable_set(var_name, value)
      end
    end
  end

  module InstanceMethods
    def add_or_init_history_value(history_var_value, history_var_name, value, name)
      if history_var_value
        instance_variable_set(history_var_name, history_var_value << value)
      else
        instance_variable_set(history_var_name, [value])
        self.class.send(:attr_reader, "#{name}_history".to_sym)
      end
    end
  end
end