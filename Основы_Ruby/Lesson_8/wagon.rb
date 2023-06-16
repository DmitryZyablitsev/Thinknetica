require_relative 'module/manufacturer'
class Wagon
  attr_reader :type
  include Manufacturer
end