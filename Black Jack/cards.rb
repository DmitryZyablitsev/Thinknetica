module Cards
  # attr_reader :deck_cards
  @@card_points = {
    '2♥' => 2, '3♥' => 3, '4♥' => 4, '5♥' => 5, '6♥' => 6, '7♥' => 7, '8♥' => 8,
    '9♥' => 9, '10♥' => 10, 'B♥' => 10, 'D♥' => 10, 'K♥' => 10, 'T♥' => 11,
    '2♦' => 2, '3♦' => 3, '4♦' => 4, '5♦' => 5, '6♦' => 6, '7♦' => 7, '8♦' => 8,
    '9♦' => 9, '10♦' => 10, 'B♦' => 10, 'D♦' => 10, 'K♦' => 10, 'T♦' => 11,
    '2♠' => 2, '3♠' => 3, '4♠' => 4, '5♠' => 5, '6♠' => 6, '7♠' => 7, '8♠' => 8,
    '9♠' => 9, '10♠' => 10, 'B♠' => 10, 'D♠' => 10, 'K♠' => 10, 'T♠' => 11,
    '2♣' => 2, '3♣' => 3, '4♣' => 4, '5♣' => 5, '6♣' => 6, '7♣' => 7, '8♣' => 8,
    '9♣' => 9, '10♣' => 10, 'B♣' => 10, 'D♣' => 10, 'K♣' => 10, 'T♣' => 11
  }
  @@deck_cards = @@card_points.keys

  def random_card
    @@deck_cards.sample
  end

  def sumcard(arr)
    sum = 0
    arr.each do |el|
      sum += @@card_points[el]
    end

    if sum > 21
      arr.select { |el| el.start_with?('T') }.count.times do
        sum -= 10
        break sum if sum <= 21
      end
    end
    sum
  end
end

# class Player
#   include Cards
# end
# pl = Player.new
# arr = ['T♠', 'K♣', 'T♣', '4♦']
# p pl.sumcard(arr)
