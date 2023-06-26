module Acсessors

  def self.included(base)
    base.extend ClassMethods
    base.include ClassInstanse
    base.class_variable_set(:@@instance_count, 0)
  end

  module ClassMethods
    def attr_reader_with_history(*names)
      names.each do |name|
        define_method(name) {instance_variable_get("@#{name.to_s}")}
      end
    end

    def attr_writer_with_history(*names)
      names.each do |name|
        define_method( "#{name}=") { |variable| instance_variable_set("@#{name}", variable) }
      end
    end

    def attr_accessor_with_history(*names)
      attr_writer_with_history(*names)
      attr_reader_with_history(*names)
    end
  end

  module ClassInstanse

  end
end


class Dog 
  include Acсessors
  # attr_reader_with_history :name, :age
  # attr_writer_with_history :name
  attr_accessor_with_history :name, :age


  def initialize(name, age)
    @name = name
    @age = age
  end

  # def name
  #   @name
  # end

  # def name= (variable)
  #   @name = name
  # end

end

dog1 =  Dog.new('Urs',5)
dog2 =  Dog.new('Raks',3)

p dog1.name
p dog1.age
p dog1.name = 'Dik'
p dog1.inspect

p dog2.name
p dog2.age
p dog2.name = 'TTT'
p dog2.inspect
