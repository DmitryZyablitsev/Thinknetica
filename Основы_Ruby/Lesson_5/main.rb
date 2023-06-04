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
  end
end