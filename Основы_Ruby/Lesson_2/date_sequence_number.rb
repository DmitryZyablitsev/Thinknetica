p 'Введите день'
day = gets.to_i
p 'Введите месяц (числом)'
month = gets.to_i
p 'Введите год'
year = gets.to_i
number_of_days_per_year = nil

if  year%4 == 0
  if year%100 == 0
    if year%400 == 0
      number_of_days_per_year = 366
    else
      number_of_days_per_year = 365
    end
  else
    number_of_days_per_year = 366
  end
else
  number_of_days_per_year = 365
end

if number_of_days_per_year == 366 
  the_ordinal_number_of_the_leap_year_date = {
    1 => 0, #31
    2 => 31, #29
    3 => 60, #31
    4 => 91, #30
    5 => 121, #31
    6 => 152, #30
    7 => 182, #31
    8 => 213, #31
    9 => 244, #30
    10 => 274, #31
    11 => 305, #30
    12 => 335, #31
  }
  p result = "Порядковый номер введённой даты #{the_ordinal_number_of_the_leap_year_date[month] +  day}"
else
  the_ordinal_number_of_a_non_leap_year_date = {
    1 => 0, #31
    2 => 31, #28
    3 => 59, #31
    4 => 90, #30
    5 => 120, #31
    6 => 151, #30
    7 => 181, #31
    8 => 212, #31
    9 => 243, #30
    10 => 273, #31
    11 => 304, #30
    12 => 334, #31
  }
  p result = "Порядковый номер введённой даты #{the_ordinal_number_of_a_non_leap_year_date[month] +  day}"
end
