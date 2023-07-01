# frozen_string_literal: true

require_relative 'module/instance_counter'
require_relative 'train'
require_relative 'module/validation'

class Station
  include InstanceCounter
  include Validation

  validate :name, :presence
  validate :name, :length, 2
  validate :name, :type, String

  def self.all
    @@stations
  end
  @@stations = []

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
     if valid?
      @@stations << self
      register_instance
    else
      validate!
    end
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

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end

  def info
    each_train do |train|
      puts "#{train.number}, тип - #{train.type}, количество вагонов - #{train.wagons.size}"
    end
  end 
end
