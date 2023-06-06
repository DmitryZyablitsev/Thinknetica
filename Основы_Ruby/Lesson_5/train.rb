class Train
  attr_accessor :speed, :current_station_index
  attr_reader :number, :route, :wagons

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    
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
    wagon.type.nil? ? (@wagons << wagon if speed == 0) : (@wagons << wagon if speed == 0 && wagon.type == self.type)
  end

  def unhook_wagon
    @wagons.pop
  end
 
end
