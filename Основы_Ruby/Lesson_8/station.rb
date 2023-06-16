require_relative 'module/instance_counter'
require_relative 'train'
class Station
  include InstanceCounter
  def self.all    
    @@stations
  end
  @@stations = []

  attr_reader :name, :trains
  
  def initialize(name) 
    validate!(name)   
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

  def valid?
    validate!(self.name)
    true
  rescue
    false
  end

  def each_train
    for i in @trains
      yield i
    end
  end

  private
  def validate!(name)    
    raise 'Название станции должно быть 2 и больше символов' if name.size < 2    
  end
end
# t1 = Train.new('111-11')
# t2 = Train.new('222-22')
# t3 = Train.new('333-33')
# st = Station.new('UK')
# st.accept_train(t1)
# st.accept_train(t2)
# st.accept_train(t3)
# st.each_train{|el| el.gain_speed(70); p el }
