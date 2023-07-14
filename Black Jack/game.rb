require_relative 'user'
require_relative 'diller'
require_relative 'money'
class Game
  include Money

  def initialize
    @greeting = 'Добро пожаловать в игру Black Jack'
    @size_of_bet = 10
    @information_about_bid = "Ставка = #{@size_of_bet} долларов"

    @user = User.new
    @user.current_funds = 100

    @diller = Diller.new
    @diller.current_funds = 100
  end

  def start
    puts @greeting
    get_name
    loop do
      puts @information_about_bid
      @user.bet(@size_of_bet)
      @diller.bet(@size_of_bet)
      # контроллер действий
      action_controller
      counting_results
      break 'Игра окончена' if @user.current_funds <= 0 || @diller.current_funds <= 0

      @user.clear_head
      @diller.clear_head
    end
  end

  private

  def get_name
    puts 'Введите ваше имя'
    @user.name = (gets.chomp)
  end

  def action_controller
    loop do
      break if @user.head.size == 3 && @diller.head.size == 3

      puts '----------ход игрока--------------------------'
      @user.get_card(2) if @user.head.empty?
      @user.show_cards
      @user.show_amount_points
      user_choice = @user.actions
      @diller.actions if @diller.head.empty?
      break if user_choice == 'Открыть карты'
    end
  end

  def counting_results
    user_points = @user.sumcard(@user.head)
    diller_points = @diller.sumcard(@diller.head)
    puts 'Ваши карты'
    @user.show_cards
    puts
    if user_points <= 21
      puts 'Карты диллера'
      @diller.show_cards
      puts
      puts "Ваше количество очков #{user_points}"
      puts "Количество очков диллера #{diller_points}"
    end

    if user_points > 21
      puts you_lost
      puts 'У вас больше 21'

    elsif diller_points > 21 || user_points > diller_points
      puts 'Вы выйграли'
      puts "#{number_dollars} #{@user.add_money(@size_of_bet * 2)}"

    elsif diller_points > user_points
      puts you_lost
      puts "#{number_dollars} #{@user.current_funds}"

    else
      puts 'Ничья'
      puts "#{number_dollars} #{@user.add_money(@size_of_bet)}"
    end
  end

  def number_dollars
    'Количество долларов'
  end

  def you_lost
    'Вы проиграли'
  end
end
game = Game.new
game.start
