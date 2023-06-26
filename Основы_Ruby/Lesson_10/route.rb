# frozen_string_literal: true

require_relative 'module/instance_counter'
require_relative 'station'

class Route
  include InstanceCounter
  attr_reader :stations, :name

  def initialize(first_station, last_station)
    validate!(first_station, last_station)
    @name = "#{first_station.name} - #{last_station.name}"
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(index, station)
    raise 'Ошибка, станции было присвоено не подходящее место' unless index.positive? && index < stations.size

    stations.insert(index, station)
  end

  def delete_station(station)
    unless station != stations.first && station != stations.last && !station.nil?
      raise 'Ошибка, введённую станцию удалить не возмоожно'
    end

    stations.delete(station)
  end

  def valid?
    validate!(stations.first, stations.last)
    true
  rescue StandardError
    false
  end

  private

  def validate!(first_station, last_station)
    raise 'Начальной и конечной станцей не может быть одна станция' if first_station == last_station
  end
end
