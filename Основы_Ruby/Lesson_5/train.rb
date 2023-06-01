class Train
  attr_accessor :speed, :current_station_index
  attr_reader :number, :route, :wagons

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    
  end

  public
  def gain_speed (speed)
    self.speed = speed
  end

  def brake
    self.speed = 0
  end

  def assign_route (route)
    @route = route
    @current_station_index = 0
  end  

  def move_next_station
    self.current_station_index += 1 if next_station
  end

  def move_previous_station 
    self.current_station_index -= 1 if previous_station
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
    @wagons << wagon if speed == 0
  end
 
end
