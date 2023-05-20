puts "Добрый день, эта программа определит идеальный вес.\nВведите, пожалуйста, ваше имя"
user_name = gets.chomp
puts 'Введите ваш рост'
user_height = gets.chomp.to_i
ideal_weight = ((user_height-110)*1.15).round(3)
if ideal_weight >= 0
  puts "#{user_name} ваш идеальный вес #{ideal_weight.to_s}" 
else
  puts "Ваш вес уже оптимальный"
end