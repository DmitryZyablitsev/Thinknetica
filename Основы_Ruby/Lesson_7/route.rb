require_relative 'module/instance_counter'
require_relative 'station'
class Route
  include InstanceCounter
  attr_reader :stations, :name

  def initialize(first_station, last_station)
    validate!(first_station, last_station)
    @name = "#{first_station.name} - #{last_station.name}"
    @stations = [first_station,last_station]
    register_instance
  end

  def add_station(index, station)
    stations.insert(index, station) if index > 0 and index < stations.size
  end

  def delete_station(station)
    stations.delete(station) if station != stations.first and station != stations.last
  end

  def valid?
    validate!(self.stations.first, self.stations.last)
    true
  rescue
    false
  end

  private
  def validate!(first_station, last_station )
    raise 'Начальной и конечной станцей не может быть одна станция' if first_station == last_station    
  end
end

# st = Station.new('UK')
# st = Station.new('UFA')
# p st = Station.new('EKB')