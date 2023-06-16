require_relative 'train'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'

class Main
  
  attr_reader :stations, :trains, :routes

  def initialize()
    @trains = []
    @stations = []
    @routes = []
    @stations << Station.new('UK') << Station.new('UFA') << Station.new('Moscow') << Station.new('SPB') << Station.new('EKB') << Station.new('Челябинск')
    @routes << Route.new(@stations[2], @stations[4]) << Route.new(@stations[0], @stations[1]) << Route.new(@stations[5], @stations[3])
    @routes[1].add_station(1, @stations[4])
    @trains << CargoTrain.new('АНА-37') << CargoTrain.new('УФА-17') << PassengerTrain.new('МСК-УК') << PassengerTrain.new('43Е-к4')
  end

  def actions_on_routes(chois)
    case chois
    when 1  # как избавиться от повторения в этом блоке?(Поможет ли Proc?)   
      begin  
      puts 'Введите номер первой станции'
      get_names(@stations, :name)
      first_station = @stations[gets.to_i]
      raise  'Станция выбрана не коректно' if first_station == nil
      rescue RuntimeError => error
        puts error
        retry
      end

      begin
      puts 'Введите номер последний станции'
      get_names(@stations, :name)   
      last_station = @stations[gets.to_i]
      raise  'Станция выбрана не коректно' if last_station == nil
      @routes << Route.new(first_station, last_station)
      rescue RuntimeError => error
        puts error
        retry
      end

    when 2
      begin 
      puts 'Выберите маршрут'
      get_names(@routes, :name)
      @current_route = @routes[gets.to_i]
      raise 'Ошибка ввода' if @current_route == nil
      rescue RuntimeError => error
        puts error
        retry
      end

      puts 'Маршрут состоит из следующих станций:'
      get_names(@current_route.stations, :name)
      puts'      1. Добавить станцию к маршруту
      2. Удалить станцию'
      add_and_delete_station_in_routes(gets.to_i)

    else     
      puts 'Введены не коректные данные'       
    end
  end

  def add_wagon_train
    puts 'Выберите поезд'
    selected_train = choice_train!
    case selected_train.type
    when :passenger      
      selected_train.add_wagon(PassengerWagon.new)
    when :cargo
      selected_train.add_wagon(CargoWagon.new)
    end    
  end

  def assign_train_route
    puts 'Выберите поезд'
    selected_train = choice_train!
    begin
      puts 'Выберите маршрут'
      get_names(@routes, :name)
      selected_train.assign_route(@routes[gets.to_i]) # поезд получил маршрут      
    rescue NoMethodError
      puts 'Ошибка ввода'
      retry
    end
  end

  def create_station
    begin
    puts 'Введите название станции'    
      @stations << Station.new(gets.chomp!)
      puts 'Станция создана'
    rescue RuntimeError => error
      puts error
      retry
    end
  end

  def creating_train
    puts   '    Выберите тип поезда
    1. Пассажирский
    2. Грузовой'
    case gets.to_i
    when 1
      begin    
        puts 'Введеите номер поезда'      
        current_train = PassengerTrain.new(gets.chomp!)
        trains << current_train
        puts "Пассажирский поезд #{current_train.number} создан"
      rescue RuntimeError => error
        puts error
        retry 
      end
    when 2
      begin
        puts 'Введеите номер поезда'
        current_train = CargoTrain.new(gets.chomp!) 
        trains << current_train
        puts "Грузовой поезд #{current_train.number} создан"
      rescue RuntimeError => error
        puts error
        retry 
      end
    else
      raise puts 'Ошибка ввода'
    end
    rescue
      retry
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
    selected_train = choice_train!
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
    choice_train!.unhook_wagon
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

  def choice_train!
    get_names(@trains, :number)    
      current_train = @trains[gets.to_i]
      raise 'Ошибка ввода, такого поезда на существует. Выберите поезд' if current_train == nil
      return current_train
    rescue RuntimeError => error
      puts error
      retry
  end

  def get_names (arr, attribute_name)
    arr.each_index {|index| puts "#{index}. #{arr[index].public_send(attribute_name)}" }
  end 

end