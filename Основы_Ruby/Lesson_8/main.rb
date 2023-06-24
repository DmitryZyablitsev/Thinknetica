# frozen_string_literal: true

require_relative 'train'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'module/error_handling'

class Main
  include ErrorHandling
  attr_reader :stations, :trains, :routes

  def initialize
    @trains = []
    @stations = []
    @routes = []
  end

  def actions_on_routes
    loop do
      puts routs_menu
      case gets.to_i
      when 1
        create_rout
        break
      when 2
        edit_route
        break
      when 3
        assign_train_route
        break
      else
        puts input_error
      end
    end
  end

  def main_menu
    '    1. Станции
    2. Поезда
    3. Маршруты
    4. Выход'
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
        break
      when 4
        unhook_wagon_train
        break
      when 5
        editing_wagons
        break
      else
        puts input_error
      end
    end
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
        station = processing_runtime_error { choose_station! }
        station.info
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

  def add_station_in_routes
    station = processing_runtime_error do
      puts 'Выберите станцию для добавления в маршрут'
      get_names(@stations, :name)
      station = @stations[gets.to_i]
      raise input_error if station.nil?

      station
    end
    processing_runtime_error do
      puts 'Выберите место в маршруте'
      get_names(@current_route.stations, :name)
      @current_route.add_station(gets.to_i, station)
      puts 'Станция добавлена'
    end
  end

  def delete_station_in_routes
    processing_runtime_error do
      puts 'Выберите станцию для удаления (кроме первой и последней)'
      get_names(@current_route.stations, :name)
      @current_route.delete_station(@current_route.stations[gets.to_i])
      puts 'Станция удалена'
    end
  end

  def add_and_delete_station_in_routes
    loop do
      puts '          1. Добавить станцию к маршруту
          2. Удалить станцию'
      case gets.to_i
      when 1
        add_station_in_routes
        break
      when 2
        delete_station_in_routes
        break
      else
        puts input_error
      end
    end
  end

  def choose_station!
    puts 'Выберите станцию'
    get_names(@stations, :name)
    station = @stations[gets.to_i]
    raise if station.nil?

    station
  end

  def choose_train!
    get_names(@trains, :number)
    current_train = @trains[gets.to_i]
    raise 'Ошибка ввода, такого поезда на существует. Выберите поезд' if current_train.nil?

    current_train
  end

  def get_names(arr, attribute_name)
    arr.each_index { |index| puts "#{index}. #{arr[index].public_send(attribute_name)}" }
  end

  def create_rout
    first_station = processing_runtime_error do
      puts 'Введите номер первой станции'
      get_names(@stations, :name)
      first_station = @stations[gets.to_i]
      raise 'Станция выбрана не коректно' if first_station.nil?

      first_station
    end

    processing_runtime_error do
      puts 'Введите номер последний станции'
      get_names(@stations, :name)
      last_station = @stations[gets.to_i]
      raise 'Станция выбрана не коректно' if last_station.nil?

      @routes << Route.new(first_station, last_station)
    end
    puts 'Маршрут создан'
  end

  def edit_route
    processing_runtime_error do
      puts 'Выберите маршрут'
      get_names(@routes, :name)
      @current_route = @routes[gets.to_i]
      raise input_error if @current_route.nil?
    end
    puts 'Маршрут состоит из следующих станций:'
    get_names(@current_route.stations, :name)
    add_and_delete_station_in_routes
  end

  def add_wagon_train
    puts 'Выберите поезд'
    selected_train = choose_train!
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
    selected_train = choose_train!
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
    processing_runtime_error do
      puts 'Введите название станции'
      @stations << Station.new(gets.chomp!)
      puts 'Станция создана'
    end
  end

  def creating_train
    loop do
      puts '    Выберите тип поезда
      1. Пассажирский
      2. Грузовой'
      case gets.to_i
      when 1
        processing_runtime_error do
          puts 'Введеите номер поезда'
          current_train = PassengerTrain.new(gets.chomp!)
          trains << current_train
          puts "Пассажирский поезд #{current_train.number} создан"
        end
        break
      when 2
        processing_runtime_error do
          puts 'Введеите номер поезда'
          current_train = CargoTrain.new(gets.chomp!)
          trains << current_train
          puts "Грузовой поезд #{current_train.number} создан"
        end
        break
      else
        puts input_error
      end
    end
  end

  def move_train
    puts 'Выберите поезд'
    selected_train = choose_train!
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

  def routs_menu
    '    1. Создать маршрут
    2. Редактировать маршрут
    3. Назначить маршрут поезду'
  end

  def stations_and_trains_on_them
    @stations.each do |station|
      puts "#{station.name}:"
      station.each_train { |train| puts "\t#{train.number}" }
    end
  end

  def unhook_wagon_train
    puts 'Выберите поезд'
    choose_train!.unhook_wagon
  end

  def editing_wagons
    current_train = processing_runtime_error { choose_train! }
    current_wagon = processing_runtime_error do
      puts 'Выберите вагон для редактирования'
      current_train.print_wagons
      current_train.choose_wagon
    end
    current_wagon.editing if current_wagon.type == :cargo
    processing_runtime_error { current_wagon.edit } if current_wagon.type == :passenger
  end

  def trains_menu
    '    1. Создать поезд
    2. Переместить поезд по маршруту
    3. Прицепить вагон
    4. Отцепить вагон
    5. Список вагонов'
  end
end
