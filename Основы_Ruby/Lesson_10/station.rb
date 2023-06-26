# frozen_string_literal: true

require_relative 'module/instance_counter'
require_relative 'train'

class Station
  include InstanceCounter
  def self.all
    @@stations
  end
  @@stations = []

  attr_reader :name, :trains

  def initialize(name)
    validate!(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def accept_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def send_train(train)
    trains.delete(train)
  end

  def valid?
    validate!(name)
    true
  rescue StandardError
    false
  end

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end

  def info
    each_train do |train|
      puts "#{train.number}, тип - #{train.type}, количество вагонов - #{train.wagons.size}"
    end
  end

  private

  def validate!(name)
    raise 'Название станции должно быть 2 и больше символов' if name.size < 2
  end
end
