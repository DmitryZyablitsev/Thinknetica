class Station 
  attr_accessor :list_of_trains
  attr_reader :number_of_trains_at_the_station_by_type, :station_name, :list_of_trains
  def initialize (station_name)
    @station_name = station_name
    @list_of_trains = {}
    @number_of_trains_at_the_station_by_type = [0,0] # первое число будет количество грузовых поездов второе пассажерских 
  end

  def accept_train (train)
    list_of_trains[train.number] = train
    train.type == :грузовой ? number_of_trains_at_the_station_by_type[0] +=1 : number_of_trains_at_the_station_by_type[1] +=1
  end


  def trains_at_the_station_by_type
    number_of_trains_at_the_station_by_type
  end

  def send_a_train (number)
    list_of_trains.delete(number.to_sym)
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
    [:грузовой, :пассажирский].include?(type.to_sym) ? @type = type.to_sym : (abort 'Не корректный тип поезда') # обработку ошибок еще не проходили
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def gain_speed (speed)
    self.speed = speed
  end

  def brake
    self.speed = 0
  end

  def attach_wagon
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
    if route.index(self.current_station) < route.size
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

# st = Station.new('UK')
# tr = Train.new('E2', 'грузовой', 60)
# tr2 = Train.new('B2', 'пассажирский', 32)
# st.accept_train(tr)
# st.accept_train(tr2)
# p st.list_of_trains
# st.send_a_train('E2')
# p st.list_of_trains

ro = Route.new('UK', 'EKB')
ro.add_station(1, 'ZLAT')



tr = Train.new('E2', 'грузовой', 60)
# tr.gain_speed(25)
# p tr.speed
# tr.brake
# p tr.speed
# p tr.number_of_wagons
# tr.attach_wagon
# p tr.number_of_wagons
# tr.unhook_wagon
# p tr.number_of_wagons
tr.assign_route(ro)
p tr.current_station
tr.move_next_station
tr.move_next_station
p tr.show_next_station
p tr.show_previous_station