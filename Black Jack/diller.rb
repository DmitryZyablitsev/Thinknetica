require_relative 'money'
require_relative 'cards'
require_relative 'player'

class Diller < Player
  include Money
  include Cards

  def initialize
    super
  end

  # действия диллера
  def actions
    puts '----------ход диллера--------------------------'
    get_card(2)
    sleep 0.5
    # puts "@head = #{@head}"
    puts '*** ***'
    # self.show_cards
    # p "self.sumcard(self.head) = #{self.sumcard(self.head)}"
    return unless sumcard(head) < 17

    sleep 0.5
    puts '*** *** ***'
    get_card
    sleep 0.5

    # puts "ПОСЛЕ действия диллера"
    # puts "@head = #{@head}"
  end

  # def skip_move
  #   acting person = 2
  # end
end
