# frozen_string_literal: true

require_relative 'module/manufacturer'
require_relative 'module/instance_counter'
require_relative 'passenger_wagon'
require_relative 'wagon'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :route, :wagons, :speed, :type

  def initialize(number)
    validate!(number)
    @number = number
    @speed = 0
    @wagons = []
    @@all << self
    register_instance
  end

  def gain_speed(speed)
    @speed = speed
  end

  def brake
    self.speed = 0
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
  end

  def move_next_station
    return unless next_station

    current_station.send_train(self)
    next_station.accept_train(self)
    self.current_station_index += 1
  end

  def move_previous_station
    return unless previous_station

    current_station.send_train(self)
    previous_station.accept_train(self)
    self.current_station_index -= 1
  end

  def next_station
    route.stations[current_station_index + 1]
  end

  def previous_station
    current_station_index.zero? ? nil : route.stations[current_station_index - 1]
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
    @@all.select { |train| train.number == number }
  end

  def valid?
    validate!(number)
    true
  rescue StandardError
    false
  end

  def each_wagon(&block)
    @wagons.each { |wagon| block.call(wagon) }
  end

  def print_wagons
    number = -1
    each_wagon do |wagon|
      number += 1
      if wagon.type == :cargo
        puts "№ #{number}, тип #{wagon.type}, кол-во свободного объёма = #{wagon.free_volume}, занятого объема = #{wagon.fullness} "

      else
        puts "№ #{number}, тип #{wagon.type}, кол-во свободных мест = #{wagon.available_seats}, занятых мест = #{wagon.occupied_seats} "
      end
    end
  end

  def choose_wagon
    current_wagon = @wagons[gets.to_i]
    raise 'Ошибка ввода, такого вагона на существует. Выберите вагон' if current_wagon.nil?

    current_wagon
  end

  private

  attr_accessor :current_station_index

  @@all = []
  @@NUMBER_TEMPLATE = /^[А-я\d]{3}-*[А-я\d]{2}$/

  def validate!(str)
    raise 'Строка должна содержать 5 или 6 символов' unless (5..6).include?(str.size)
    return unless str !~ @@NUMBER_TEMPLATE

    raise 'Номер поезда не удовлетворяет шаблону, 3 буквы или цифры, не обязательный дефис, далее 2 буквы или цифры'
  end
end
