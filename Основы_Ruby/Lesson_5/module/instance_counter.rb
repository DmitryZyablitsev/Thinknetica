module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.class_variable_set(:@@count_intance, 0)
  end
  

  define_method(:register_instance, { @@count_intance += 1})

  module ClassMethods
    
    def instances
      @@count_intance
    end
  end
end
