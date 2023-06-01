require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    @type = :cargo    
    super(number)
  end

  def add_wagon(wagon)
    super(wagon) if wagon.type == self.type
  end
end