shopping_cart = {}
loop do
  p 'Введите название товара или \'стоп\' для перехода к оплате'
  product_name = gets.chomp.to_sym
  break if product_name == :стоп
  p 'Введите цену за единицу товара'
  price_per_item = gets.to_f
  p 'Введите количество'
  quantity_of_goods = gets.to_i
  shopping_cart[product_name] = { price_per_item => quantity_of_goods }
end

total_for_one_type_of_product = nil
result = 0
puts ''
shopping_cart.each_pair do |key, value|
  puts "Название товара: #{key}"
  value.each_pair do |price, quantity|
    puts "Цена за 1 шт.: #{price} р."
    puts "Количество: #{quantity}"    
    total_for_one_type_of_product = price * quantity
    puts "Цена: #{total_for_one_type_of_product } р.\n\n"
    result += total_for_one_type_of_product
  end
end
puts '---------------------------------------------------------'
puts "Итог #{result} р."



