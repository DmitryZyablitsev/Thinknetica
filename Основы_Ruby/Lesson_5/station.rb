require_relative 'module/instance_counter'
class Station
  include InstanceCounter
  def self.all    
    @@stations
  end
  @@stations = []

  attr_reader :name, :trains
  
  def initialize(name)    
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end
  

  def accept_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select{ |train| train.type == type }
  end

  def send_train(train)
    trains.delete(train)
  end
end