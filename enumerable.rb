# frozen_string_literal: true

# doc comment

def my_each(input, index = 0)
  output = []
  range = input.length - index
  range.times do
    output.push(yield(input[index]))
    index += 1
  end
  output
end

def my_each_with_index(input, index = 0)
  output = []
  range = input.length - index
  range.times do
    output.push("#{yield(input[index])}. #{index}")
    index += 1
  end
  output
end

def my_select(input, index = 0)
  output = []
  range = input.length - index
  range.times do
    output.push(input[index]) if yield(input[index])
    index += 1
  end
  output
end

def my_all?(input, index = 0)
  output = true
  while index < input.length
    return false if yield(input[index]) == false

    index += 1
  end
  output
end

def my_any?(input, index = 0)
  output = false
  while index < input.length
    return true if yield(input[index]) == true

    index += 1
  end
  output
end

def my_none?(input, index = 0)
  output = true
  while index < input.length
    return false if yield(input[index]) == true

    index += 1
  end
  output
end

def my_count(input, index = 0)
  counter = 0
  return input.length unless block_given?

  while index < input.length
    counter += 1 if yield(input[index]) == true

    index += 1
  end
  counter
end

def my_map(input, index = 0)
  return input unless block_given?

  output = []
  range = input.length - index
  range.times do
    output.push(yield(input[index]))
    index += 1
  end
  output
end

def my_inject
  nil
end

# puts my_each([1, 2, 3, 4, 5, 6], 3) { |x| x * 3 }
# puts my_each_with_index([1, 2, 3, 4, 5, 6]) { |x| x * 3 }
# puts my_select([1, 2, 3, 4, 5, 6]) { |x| x >= 1 }
# puts my_all?([1, 2, 3, 4, 5, 6]) { |x| x <= 6 }
# puts my_any?([1, 2, 3, 4, 5, 6, 8]) { |x| x > 4 }
# puts my_none?([1, 2, 3, 4, 5, 6]) { |x| x > 5 }
# puts my_count([1, 2, 3, 4, 5, 6]) { |x| x >= 1 }
# puts my_map([1, 2, 3, 4, 5, 6]) { |x| x * x }
