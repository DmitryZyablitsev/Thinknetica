require_relative 'wagon'
class CargoWagon < Wagon
  attr_reader :type, :fullness
  def initialize(total_volume)
    @total_volume = total_volume # общий объём
    @fullness = 0 # запольненность
    @type = :cargo
  end

  def fill(meaning)
    @fullness += meaning
  end

  def free_volume
    @total_volume - @fullness
  end
end
