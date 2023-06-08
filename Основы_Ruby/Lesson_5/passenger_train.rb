require_relative 'train'
require_relative 'passenger_wagon'

class PassengerTrain < Train
  attr_reader :type
  def initialize(number)
    @type  = :passenger
    super(number)
  end
end