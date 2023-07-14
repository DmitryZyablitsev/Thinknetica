require_relative 'game'
loop do
  game = Game.new
  Game.start
  break #if result.zero?
end