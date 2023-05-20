puts 'Решим квадратное уравнение'
puts 'Введитие коэффициент a'
coefficient_a = gets.to_f
puts 'Введитие коэффициент b'
coefficient_b = gets.to_f
puts 'Введитие коэффициент c'
coefficient_c = gets.to_f

discriminant = coefficient_b**2 - 4 * coefficient_a * coefficient_c
puts "Дискрименант равен #{discriminant}"
case 
  when discriminant < 0
    puts "Корней нет"
  when discriminant == 0
    puts "x = #{-coefficient_b / (2 * coefficient_a)}"  
  else
    puts "x1 = #{(-coefficient_b - Math.sqrt(discriminant)) / (2 * coefficient_a)}"
    puts "x2 = #{(-coefficient_b + Math.sqrt(discriminant)) / (2 * coefficient_a)}"
end

