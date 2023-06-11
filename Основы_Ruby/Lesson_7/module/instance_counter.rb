module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.include ClassInstanse
    base.class_variable_set(:@@instance_count, 0)
  end

  module ClassMethods
    def instances
      self.class_variable_get(:@@instance_count)
    end
  end

  module ClassInstanse
    private
    def register_instance
      counter = self.class.class_variable_get(:@@instance_count)
      counter += 1
      self.class.class_variable_set(:@@instance_count, counter)
    end
  end
end

class Train 
  include InstanceCounter  
  def initialize
    register_instance    
  end
end


