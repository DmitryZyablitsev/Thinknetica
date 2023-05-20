months_and_number_of_days = {
  Январь: 31,
  Февраль: 28,
  Март: 31,
  Апрель:  30,
  Май: 31,
  Июнь: 30,
  Июль: 31,
  Август: 31,
  Сентябрь: 30,
  Октябрь: 31,
  Ноябрь: 30,
  Декабрь: 31
}


months_and_number_of_days.each do |key, value|
  p key if value == 30
 
end