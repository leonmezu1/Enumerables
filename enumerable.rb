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
  trigger = true
  output = true
  range = input.length
  while trigger && index < range
    trigger && output = false if yield(input[index]) == false
    index += 1
  end
  output
end

def my_any?(input, index = 0)
  trigger = true
  output = false
  while trigger && index < input.length
    if yield(input[index]) == true
      trigger = false
      output = true
    end
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

def my_count
  nil
end

def my_map
  nil
end

def my_inject
  nil
end

# puts my_each([1, 2, 3, 4, 5, 6], 3) { |x| x * 3 }
# puts my_each_with_index([1, 2, 3, 4, 5, 6]) { |x| x * 3 }
# puts my_select([1, 2, 3, 4, 5, 6]) { |x| x >= 1 }
# puts my_all?([1, 2, 3, 4, 5, 6]) { |x| x > -1 }
# puts my_any?([1, 2, 3, 4, 5, 6]) { |x| x == 5 }
puts my_none?([1, 2, 3, 4, 5, 6]) { |x| x > 5 }
