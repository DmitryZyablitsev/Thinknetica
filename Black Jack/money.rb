module Money
  # attr_accessor :current_funds
  attr_reader :current_funds

  # добавить
  def add_money(quantity)
    @current_funds += quantity
  end

  # ставка
  def bet(quantity)
    @current_funds -= quantity
  end

  # текущие средства
  def current_funds=(quantity)
    @current_funds = quantity
    # p "current_funds= ID = #{@current_funds.__id__}"
  end
end

# class Player
#   include Money
# end

# p1 = Player.new
# p p1.current_funds= 100
# p p1.bet(10)
# p p1.add_money(20)
# p p1.current_funds
