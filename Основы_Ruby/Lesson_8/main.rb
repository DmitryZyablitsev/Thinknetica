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
    @trains[0].assign_route(@routes[0])
    @trains[3].assign_route(@routes[0])
    @trains[1].assign_route(@routes[1])
    @trains[2].assign_route(@routes[2])
    @trains[0].add_wagon(CargoWagon.new(600))
    @trains[0].add_wagon(CargoWagon.new(500))
    @trains[0].add_wagon(CargoWagon.new(400))
    @trains[0].add_wagon(CargoWagon.new(300))
    @trains[2].add_wagon(PassengerWagon.new(1))
    @trains[2].add_wagon(PassengerWagon.new(50))
    @trains[2].add_wagon(PassengerWagon.new(34))
    @trains[2].add_wagon(PassengerWagon.new(26))



  end

  def actions_on_routes
    loop do
      puts rours_menu      
      case gets.to_i
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
        puts 'Маршрут создан'
        break

      when 2
        begin 
          puts 'Выберите маршрут'
          get_names(@routes, :name)
          @current_route = @routes[gets.to_i]
          raise input_error if @current_route == nil
        rescue RuntimeError => error
          puts error
          retry
        end        
          puts 'Маршрут состоит из следующих станций:'
          get_names(@current_route.stations, :name)          
          add_and_delete_station_in_routes
        break

      when 3
        assign_train_route()  
        break      
      else
        puts input_error
      end
    end
  end

  def add_wagon_train
    puts 'Выберите поезд'
    selected_train = choice_train!
    case selected_train.type
    when :passenger      
      puts 'Введите количесво мест в пассажирском вагоне'
      selected_train.add_wagon(PassengerWagon.new(gets.to_i))
    when :cargo
      puts 'Введите объём грузового вагона'
      selected_train.add_wagon(CargoWagon.new(gets.to_i))
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
    '    1. Станции
    2. Поезда
    3. Маршруты
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
    2. Редактировать маршрут
    3. Назначить маршрут поезду'
  end

  def stations_and_trains_on_them      
    @stations.each do |station|
      puts "#{station.name}:"
      station.each_train{|train| puts "\t#{train.number}"}
    end
  end

  def unhook_wagon_train 
    puts 'Выберите поезд'
    choice_train!.unhook_wagon
  end

  def actions_on_trains
    loop do
      puts trains_menu
      case gets.to_i
      when 1
        creating_train
        break
      when 2
        move_train
        break
      when 3
        add_wagon_train
      when 4
        unhook_wagon_train
        break
      when 5
        current_train = choice_train!
        print_wagons(current_train)
        puts 'Выберите вагон для редактирования'
        current_wagon = current_train.wagons[gets.to_i - 1]
        if current_wagon.type == :cargo
          puts "В вагоне свободно #{current_wagon.free_volume}, введите количество загрузки "
          current_wagon.fill(gets.to_i)
          puts 'Вагон успешно загружен'
        end
        if current_wagon.type == :passenger
          puts "В вагоне свободно #{current_wagon.available_seats}"
          puts '        Занять место?
          1. Да
          2. Нет'
          case gets.to_i
          when 1
            begin
              current_wagon.take_a_seat # Занять место
              puts 'Место Занято'
            rescue RuntimeError => error
              puts error  
            end        
          end
        end
        break
      else
        puts input_error
      end
    end
  end

  def print_wagons(train)
    number = 0
    train.each_wagon do |wagon|
      number += 1
      if wagon.type == :cargo
      puts "№ #{number}, тип #{wagon.type}, кол-во свободного объёма = #{wagon.free_volume}, занятого объема = #{wagon.fullness} "
      
      else
        puts "№ #{number}, тип #{wagon.type}, кол-во свободных мест = #{wagon.available_seats}, занятых мест = #{wagon.occupied_seats} "
      end      
    end
  end

  def trains_menu
    '    1. Создать поезд
    2. Переместить поезд по маршруту
    3. Прицепить вагон
    4. Отцепить вагон
    5. Список вагонов'
  end

  def actions_on_station
    loop do
      puts '    Выберите:
      1. Создать станцию
      2. Список поездов на станции'
      case gets.to_i
      when 1
        create_station
        break
      when 2
        begin
        puts 'Выберите станцию'        
        get_names(@stations, :name)
        station = @stations[gets.to_i]
        raise if station.nil?
        station.each_train do |train|
          puts "#{train.number}, тип - #{train.type}, количество вагонов - #{train.wagons.size}"
        end
        rescue 
          puts input_error
          retry
        end
        break
      else
        puts input_error
      end
    end
  end

  def input_error
    'Ошибка ввода' 
  end

  protected 

  def add_and_delete_station_in_routes
    loop do
      puts '          1. Добавить станцию к маршруту
          2. Удалить станцию'
      case gets.to_i
      when 1
        begin
          puts 'Выберите станцию для добавления в маршрут'
          get_names(@stations, :name)
          station = @stations[gets.to_i]
          raise input_error if station.nil?
        rescue RuntimeError => error
          puts error
          retry
        end
        begin
          puts 'Выберите место в маршруте'
          get_names(@current_route.stations, :name)
          index = gets.to_i
          @current_route.add_station(index,station) # метод add_station может вернуть исключение
        rescue RuntimeError => error
          puts error
          retry
        end
        break
      when 2
        puts 'Выберите станцию для удаления (кроме первой и последней)'
        get_names(@current_route.stations, :name)
        @current_route.delete_station(@current_route.stations[gets.to_i])    
        break
      else
        puts input_error
      end
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