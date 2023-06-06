require_relative 'class_main'


program = Main.new
loop do
  puts program.main_menu
  case gets.to_i
  when 1
    program.create_station
  when 2
    program.creating_train
  when 3
    puts program.rours_menu
    program.actions_on_routes(gets.to_i)    
  when 4    
    program.assign_train_route  
  when 5
    program.add_wagon_train
  when 6
    program.unhook_wagon_train
  when 7
    program.move_train
  when 8
    program.stations_and_trains_on_them
  end


end