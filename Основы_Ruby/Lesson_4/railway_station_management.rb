class Station
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
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



class Route
  attr_accessor :stations

  def initialize (first_station, last_station)
    @stations = [first_station,last_station]
  end

  def add_station(index, station)
    stations.insert(index, station) if index > 0 and index < stations.size
  end

  def delete_station(station)
    stations.delete(station) if station != stations.first and station != stations.last
  end
end



class Train
  attr_accessor :quantity_wagons, :speed, :current_station_index
  attr_reader :number, :type, :route

  def initialize(number, type, quantity_wagons)
    @number = number
    @type = type
    @quantity_wagons = quantity_wagons
    @speed = 0
  end

  def gain_speed (speed)
    self.speed = speed
  end

  def brake
    self.speed = 0
  end

  def add_wagon
    self.quantity_wagons += 1 if speed == 0
  end

  def unhook_wagon
    self.quantity_wagons -=1 if speed = 0 && quantity_wagons > 0
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
end