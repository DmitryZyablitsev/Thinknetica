require_relative 'train'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'station'
require_relative 'route'
class Main
  
  attr_reader :stations, :trains, :routes

  def initialize()
    @trains = []
    @stations = []
    @routes = []
    # @stations << Station.new('UK') << Station.new('UFA') << Station.new('Moscow') << Station.new('SPB') << Station.new('EKB') << Station.new('Челябинск')
    # @routes << Route.new(@stations[2], @stations[4]) << Route.new(@stations[0], @stations[1]) << Route.new(@stations[5], @stations[3])
    # @routes[1].add_station(1, @stations[4])
    # @trains << CargoTrain.new('#37') << CargoTrain.new('#51') << PassengerTrain.new('R94') << PassengerTrain.new('D102')
  end

  def actions_on_routes(chois)
    case chois
    when 1
      puts 'Введите номер первой станции'
      get_names(@stations, :name)
      first_station = @stations[gets.to_i]
      puts 'Введите номер последний станции'      
      last_station = @stations[gets.to_i]
      @routes << Route.new(first_station, last_station)
    when 2
      puts 'Выберите маршрут'
      get_names(@routes, :name)
      @current_route = @routes[gets.to_i] # исправить @current_route
      puts 'Маршрут состоит из следующих станций:'
      get_names(@current_route.stations, :name)
      puts'      1. Добавить станцию к маршруту
      2. Удалить станцию'
      add_and_delete_station_in_routes(gets.to_i)
    end
  end

  def add_wagon_train
    puts 'Выберите поезд'
    selected_train = choice_train
    case selected_train.type
    when :passenger      
      selected_train.add_wagon(PassengerWagon.new)
    when :cargo
      selected_train.add_wagon(CargoWagon.new)
    end 
    p selected_train.wagons
  end

  def assign_train_route
    puts 'Выберите поезд'    
    selected_train = choice_train
    puts 'Выберите маршрут'
    get_names(@routes, :name)
    selected_train.assign_route(@routes[gets.to_i]) # поезд получил маршрут
  end

  def create_station()
      puts 'Введите название станции'
      @stations << Station.new(gets.chomp!)      
  end

  def creating_train
    puts   '    Выберите тип поезда
    1. Пассажирский
    2. Грузовой'
    case gets.to_i
    when 1
      puts 'Введеите номер поезда'
      trains << PassengerTrain.new(gets.chomp!)
    when 2
      puts 'Введеите номер поезда'
      trains << CargoTrain.new(gets.chomp!) 
    else
      puts 'Ошибка ввода'
    end
  end

  def main_menu
    '    1. Создать станцию
    2. Создать поезд
    3. Маршруты
    4. Назначить маршрут поезду
    5. Добавить вагон к поезду
    6. Отцепить вагон от поезда
    7. Переместить поезд по маршруту
    8. Просмотреть список станций и список поездов на станции
    9. Выход'
  end

  def move_train
    puts 'Выберите поезд'
    selected_train = choice_train
    puts '    Переместить поезд на одну станцию
    1. Вперед
    2. Назад'
    case gets.to_i
    when 1
      selected_train.move_next_station
    when 2      
        selected_train.move_previous_station      
    end
  end

  def rours_menu
    '    1. Создать маршрут
    2. Редактировать маршрут'
  end

  def stations_and_trains_on_them      
    @stations.each do |station|
      puts "#{station.name}:"
      station.trains.each{|train| puts "\t#{train.number}"}
    end
  end

  def unhook_wagon_train 
    puts 'Выберите поезд'
    choice_train.unhook_wagon
  end

  protected 

    def add_and_delete_station_in_routes(choice)
    case choice
    when 1
      puts 'Выберите станцию для добавления в маршрут'
      get_names(@stations, :name)
      station = @stations[gets.to_i]
      puts 'Выберите место в маршруте'
      get_names(@current_route.stations, :name)
      index = gets.to_i
      @current_route.add_station(index,station)
    when 2
      puts 'Выберите станцию для удаления (кроме первой и последней)'
      get_names(@current_route.stations, :name)
      @current_route.delete_station(@current_route.stations[gets.to_i])
    end
  end

  def choice_train
    get_names(@trains, :number)        
    @trains[gets.to_i] 
  end

  def get_names (arr, attribute_name)
    arr.each_index {|index| puts "#{index}. #{arr[index].public_send(attribute_name)}" }
  end 

end