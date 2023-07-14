require_relative 'money'
require_relative 'cards'
require_relative 'player'

class User < Player
  include Money
  include Cards

  attr_accessor :name

  def initialize
    super
  end

  def skip
    'Пропустить'
  end

  def open_card
    'Открыть карты'
  end

  # @all_actions = {
  # 1 => instance_method(:skip),
  # 2 => instance_method(:get_card),
  # 3 => instance_method(:open_card),
  # }

  # действия игрока
  def actions
    if head.size == 2
      puts '1. Пропустить '
      puts '2. Добавить карту'
      puts '3. Открыть карты'
      case gets.to_i
      when 1
        skip
      when 2
        get_card(1)
      when 3
        open_card

      else
        puts 'Ошибка ввода'
      end
    elsif head.size == 3
      puts '3. Открыть карты'
      return open_card if gets.to_i == 3
    end
  end
end

# pl = User.new
# p pl.get_card
