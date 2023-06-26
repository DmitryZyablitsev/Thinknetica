# frozen_string_literal: true

require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    @type = :cargo
    super(number)
  end
end