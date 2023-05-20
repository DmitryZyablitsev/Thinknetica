

hash = {}
('a'..'z').each_with_index do |el, index|
  hash[el] = index+1 if %w[a e i o u y].include?(el)
end

p hash