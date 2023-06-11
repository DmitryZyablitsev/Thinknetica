require_relative 'module/manufacturer'
require_relative 'module/instance_counter'
class Train 
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :route, :wagons, :speed, :type  

  def initialize(number) 
    validate! (number)
    @number = number    
    @speed = 0
    @wagons = []
    @@all << self  
    register_instance
  end

  def gain_speed (speed)
    self.speed = speed
  end

  def brake
    self.speed = 0
  end

  def assign_route (route)
    @route = route
    @current_station_index = 0
    self.current_station.accept_train(self)
  end  

  def move_next_station
    if next_station
      self.current_station.send_train(self)
      self.next_station.accept_train(self)
      self.current_station_index += 1
    end
  end

  def move_previous_station 
    if previous_station
    self.current_station.send_train(self)
    self.previous_station.accept_train(self)
    self.current_station_index -= 1
    end
  end

  def next_station
    route.stations[current_station_index + 1]
  end

  def previous_station
    current_station_index == 0 ? nil : route.stations[current_station_index - 1] 
  end

  def current_station
    route.stations[current_station_index]
  end

  def add_wagon(wagon)
    return unless speed.zero?
    @wagons << wagon if wagon.type == type
  end

  def unhook_wagon
    @wagons.pop
  end

  def self.find(number)
    @@all.select{ |train| train.number == number}
  end

  def valid?
    validate!(self.number)
    true
  rescue
    false
  end

  private 
  attr_accessor :current_station_index
  @@all = []
  @@NUMBER_TEMPLATE = /^[\w]{3}-*[\w]{2}$/i

  def validate! (str)
    raise 'Строка должна содержать 5 или 6 символов' unless (5..6).include?(str.size)
    raise 'Номер поезда не удовлетворяет шаблону, 3 буквы или цифры, не обязательный дефис, далее 2 буквы или цифры' if  str !~ @@NUMBER_TEMPLATE
  end
end

# p st = Train.new('EQW32')
# p st.valid?