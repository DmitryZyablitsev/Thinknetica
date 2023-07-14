require_relative 'money'
require_relative 'cards'

class Player
  attr_reader :cash, :head

  def initialize
    @head = []
    @@used_cards = []
  end

  def clear_head
    @head.clear
    @@used_cards.clear
  end

  # получить карту
  def get_card(quantity = 1)
    control_number_cards = @head.size + quantity
    loop do
      incidental_card = random_card
      next if @@used_cards.include?(incidental_card)

      @@used_cards << incidental_card
      @head << incidental_card
      return @head if control_number_cards == @head.size
    end
  end

  # показать карты пользователю
  def show_cards
    @head.each { |card| print card, ' ' }
  end

  # показать сумму очков
  def show_amount_points
    puts "Сумма очков = #{sumcard(head)}"
  end
end

# class User < Player
# end
# pl = User.new
# p pl.get_card
