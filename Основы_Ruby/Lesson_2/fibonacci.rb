arr = [ 1, 1]
loop do
  next_number = arr[-2] + arr[-1]
  next_number > 100 ? break : arr.push(next_number)
end

p arr