require_relative 'wagon'
class PassengerWagon
  attr_reader :type, :number_of_seats, :available_seats
  def initialize(number_of_seats)
    @type = :passenger
    @number_of_seats = number_of_seats  # Количество мест
    @available_seats = number_of_seats  # Свободные места
    #@occupied_seats = 0                # Занятые места
  end

  def take_a_seat # Занять место
    @available_seats -= 1    
  end 

  def occupied_seats
    @number_of_seats - @available_seats
  end
end


# pw1 = PassengerWagon.new(35)

# p pw1.number_of_seats
# p pw1.take_a_seat
# p pw1.available_seats
# p pw1.occupied_seats
 