def validate_input(string)
  if (string.chars - ['1', '0']).any? || string.length != 7
    puts '7 цифр "0" и "1"'
    exit(1)
  end
end

def input_to_bits(string)
  string.chars.map(&:to_i)
end

def syndrome(arr)
  s1 = (arr[0] + arr[2] + arr[4] + arr[6]) % 2
  s2 = (arr[1] + arr[2] + arr[5] + arr[6]) % 2
  s3 = (arr[3] + arr[4] + arr[5] + arr[6]) % 2
  [s1, s2, s3]
end

def has_error(arr)
  syndrome(arr) != [0, 0, 0]
end

def error_index(arr)
  syndrome(arr).reverse.join('').to_i(2)
end

def error_symbol(arr)
  { 1 => 'r1', 2 => 'r2', 3 => 'i1', 4 => 'r3', 5 => 'i2', 6 => 'i3', 7 => 'i4' }[error_index(arr)]
end

def inf_bits(arr)
  [arr[2], arr[4], arr[5], arr[6]]
end

def make_result_message(bits)
  bits.join('')
end

def fixed_message(arr)
  if !has_error(arr) || error_symbol(arr)[0] == 'r'
    make_result_message(inf_bits(arr))
  else
    ind = error_symbol(arr)[1].to_i - 1
    result = inf_bits(arr)
    result[ind] = (result[ind] + 1) % 2
    make_result_message(result)
  end
end

print 'Введите 7 цифр "0" и "1": '
inp = gets.chomp
validate_input(inp)

bits = input_to_bits(inp)
if has_error(bits)
  puts "В сообщении ошибка\nВ символе #{error_symbol(bits)}"
else
  puts 'В сообщении нет ошибки(-ок)'
end

puts "Правильное сообщение: #{fixed_message(bits)}"
