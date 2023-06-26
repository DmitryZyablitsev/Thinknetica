# frozen_string_literal: true

require_relative 'wagon'
require_relative 'module/error_handling'

class PassengerWagon
  attr_reader :type, :number_of_seats, :occupied_seats

  def initialize(number_of_seats)
    @type = :passenger
    @number_of_seats = number_of_seats # Количество мест
    @occupied_seats = 0 # Занятые места
  end

  # Занять место
  def take_a_seat
    raise 'Свободных мест нет' if @occupied_seats == @number_of_seats
    @occupied_seats += 1
  end

  def available_seats
    @number_of_seats - @occupied_seats
  end

  def edit() 
    edit_menu
    choose = gets.to_i
    if choose == 1
      take_a_seat()    
      puts 'Место занято'
    elsif choose == 2
      puts 'Место освобождено'    

    else
      raise 'Ошибка ввода'
    end

  end

  def edit_menu
    puts "В вагоне свободно #{current_wagon.available_seats}"
    puts '    1. Занять место
    2. Освободить место'
  end
end
