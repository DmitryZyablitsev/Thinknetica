# frozen_string_literal: true

require_relative 'main'

program = Main.new

hash = {
  1 => program.method(:actions_on_station),
  2 => program.method(:actions_on_trains),
  3 => program.method(:actions_on_routes),
  4 => method(:abort)
}
hash.default = -> { puts program.input_error }

loop do
  puts program.main_menu
  hash[gets.to_i].call
end