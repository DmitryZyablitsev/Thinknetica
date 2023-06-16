require_relative 'main'

program = Main.new
loop do
  puts program.main_menu
  case gets.to_i
  when 1
    program.actions_on_station
  when 2
    program.actions_on_trains
  when 3   
    program.actions_on_routes    
  when 8
    program.stations_and_trains_on_them
  when 9
    abort
  else
    puts program.input_error
  end
end