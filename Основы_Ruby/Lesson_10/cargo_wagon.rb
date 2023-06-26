# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :fullness

  def initialize(total_volume)
    @total_volume = total_volume # общий объём
    @fullness = 0 # запольненность
    @type = :cargo
  end

  def fill(meaning)
    if @fullness + meaning <=  @total_volume
      @fullness += meaning 
      puts 'Вагон успешно загружен'
    else
      puts 'Ошибка, отсутствует столько места'
    end
  end

  def to_free(meaning)
    if @fullness - meaning >=  0
      @fullness -= meaning
    else
      puts 'Ошибка, попытка разгрузить больще объёма, чем есть в вагоне'
    end
  end

  def free_volume
    @total_volume - @fullness
  end

  def editing
    puts '    1. Загрузить вагон
    2. Разгрузить вагон'
    case gets.to_i
    when 1
      load     
    when 2
      unload
    end
  end

  def load 
    puts "В вагоне свободно #{free_volume}, введите количество загрузки "
    fill(gets.to_i)
  end

  def unload
    puts "В вагоне занято #{@fullness}, введите сколько разгрузить "
    to_free(gets.to_i)
  end
end