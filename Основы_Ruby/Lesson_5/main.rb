require_relative 'train'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'station'



puts 'Программа управления жд станцией'
loop do
  trains = []
  puts str = <<EOF
  1. Создать станцию
  2. Создать поезда
  3. Создать маршрут поезду
  4. Назначить маршрут поезду
  5. Добавить вагон к поезду
  6. Отцепить вагон от поезда
  7. Переместить поезд по маршруту вперед
  8. Переместить поезд по маршруту назад
  9. Просматреть список станций и список поездов на станции
EOF
  selection_in_main_menu = gets.to_i

  case selection_in_main_menu
  when 1
    puts 'Введите название станции'
    stations = [] << Station.new(gets.chomp!) # не уверен что тут нужен массив

  when 2    
    puts 'Выберите тип поезда
    1. Пассажирский
    2. Грузовой'
    type = gets.to_i
    puts 'Введите номер поезда' if type == 1 || type == 2 # вынес сюда чтобы не дублировать код в if и elsif
    if type == 1      
      trains << PassengerTrain.new(gets.chomp!)
    elsif type == 2      
      trains << CargoTrain.new(gets.chomp!) 
    else
      puts 'Ошибка ввода'      
    end

  when 3

  else
  end
end
