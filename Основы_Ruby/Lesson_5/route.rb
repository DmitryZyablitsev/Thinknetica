class Route
  attr_accessor :stations

  def initialize (first_station, last_station)
    @stations = [first_station,last_station]
  end

  def add_station(index, station)
    stations.insert(index, station) if index > 0 and index < stations.size
  end

  def delete_station(station)
    stations.delete(station) if station != stations.first and station != stations.last
  end
end