class Station 
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []    
  end

  def accept_train (train)
    trains.push train
  end

  def trains_by_type(type)
    trains.select{|train| train.type == type }
  end

  def send_a_train (train)
    trains.delete(train)
  end
end




class Route
  attr_accessor :route # команда xxx.route может выводить список всех станций по-порядку от начальной до конечной

  def initialize (first_station, last_station)
    @route = [first_station,last_station]
  end

  def add_station (index, station)
    route.insert(index, station) if (0..route.size-1).include?(index)
  end

  def delete_station (station)
    route.delete(station)
  end
end




class Train 
  attr_accessor :speed, :current_station, :number_of_wagons # speed вернет текущую скорость, метод не стал писать 
  attr_reader :number, :type, :route

  def initialize (number, type, number_of_wagons)
    @number = number.to_sym
    @type = type.to_sym
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def gain_speed (speed)
    self.speed = speed
  end

  def brake
    self.speed = 0
  end

  def add_wagon
    self.number_of_wagons += 1 if speed == 0
  end

  def unhook_wagon
    self.number_of_wagons -=1 if speed = 0 && number_of_wagons > 0
  end

  def assign_route(route)
    @route = route.route
    self.current_station = self.route.first
  end

  def move_next_station
    if route.index(self.current_station) < route.size - 1
      self.current_station = route[route.index(self.current_station) + 1]
    end
  end

  def move_previous_station
    if route.index(self.current_station) > 0
      self.current_station = route[route.index(self.current_station) - 1]
    end
  end

  def show_next_station
    route[route.index(self.current_station)+ 1]
  end

  def show_previous_station
    if route.index(self.current_station) > 0
    route[route.index(self.current_station) - 1]
    else
      nil
    end    
  end
end