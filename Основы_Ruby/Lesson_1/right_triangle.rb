array_of_sides = []
result = ""

puts 'Введите первую сторну треугольника'
array_of_sides << first_side = gets.to_f

puts 'Введите вторую сторну треугольника'
array_of_sides << second_side = gets.to_f

puts 'Введите третью сторну треугольника'
array_of_sides << third_side = gets.to_f

# проверим что введенные данные могут являться треугольником
if first_side >= second_side + third_side || second_side >= first_side + third_side || third_side >= first_side + second_side
  abort "Не коректные данные, такой треугольник не возможен"
end


def rectangular? (array_sides) # проверка на прямоугольность
  ((array_sides.delete(array_sides.max))**2).round == (array_sides[0]**2 + array_sides[1]**2).round
end



case array_of_sides.uniq.size # количество не повторяющихся сторон треугольника
when 1
  puts 'Треугольник равносторонний'

when 2 # проверка на равнобедренность
  if array_of_sides.count(array_of_sides.max) == 1 # если максимальное число в массиве одно треугольник оказаться быть прямоугольным
    if rectangular?(array_of_sides.clone) # проверка на прямоугольность
      abort 'Треугольник является равнобедренным и прямоугольным'
    end    
  end
  puts 'Треугольник равнобедренный'

else  # в треугольнике нет сторон одной длинны
  if rectangular?(array_of_sides.clone)
    puts 'Треугольник является прямоугольным'
  else
    puts "Треугольник не является ни равносторонним, ни равнобедренным, ни прямоугольным"
  end
end


  



