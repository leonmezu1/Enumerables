# frozen_string_literal: true

# rubocop: disable Metrics/MethodLength
# doc comment
module Enumerable
  def my_each
    i = 0
    output = []
    length.times do
      output.push(yield(self[i]))
      i += 1
    end
    output
  end

  def my_each_with_index(index = 0)
    output = []
    range = length - index
    range.times do
      output.push("#{yield(self[index])}. #{index}")
      index += 1
    end
    output
  end

  def my_select(index = 0)
    output = []
    range = length - index
    range.times do
      output.push(self[index]) if yield(self[index])
      index += 1
    end
    output
  end

  def my_all?(index = 0)
    output = true
    unless block_given?
      while index < length
        return false if self[index] == false

        index += 1
      end
    end
    while index < length
      return false if yield(self[index]) == false

      index += 1
    end
    output
  end

  def my_any?(index = 0)
    output = false
    unless block_given?
      while index < length
        return true if self[index] == true

        index += 1
      end
    end
    while index < length
      return true if yield(self[index]) == true

      index += 1
    end
    output
  end

  def my_none?(index = 0)
    output = true
    unless block_given?
      while index < length
        return false if self[index] == true

        index += 1
      end
    end
    while index < length
      return false if yield(self[index]) == true

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

  def my_inject(input, aux = 0)
    return input if input.length < 2

    accumulator = yield(yield(input[0], aux), input[1])
    if input.length > 2
      i = 2
      input.length - 2.times do
        accumulator = yield(accumulator, input[i])
        i += 1
      end
    end
    accumulator
  end
end

# rubocop: enable Metrics/MethodLength

# puts my_each([1, 2, 3, 4, 5, 6], 3) { |x| x * 3 }
# puts [1, 2, 3, 4, 5, 6].my_each_with_index(2) { |x| x * 3 }
# puts [1, 2, 3, 4, 5, 6].my_select { |x| x >= 4 }
# puts [1, 2, 3, 4, 5, 6].my_all? { |x| x <= 6 }
# puts [1, 2, 3, 4, 5, 6, 8].my_any?(2) { |x| x > 8 }
#  puts [false, false].my_none?
# puts my_count([1, 2, 3, 4, 5, 6]) { |x| x >= 1 }
# puts my_map([1, 2, 3, 4, 5, 6]) { |x| x * x * x }

# arr = [2, 2, 3, 4]

# puts arr.my_select(3) { |x| x > 2 }
