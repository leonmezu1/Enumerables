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
    unless block_given?
      while index < input.length
        return false if input[index] == false

        index += 1
      end
    end
    while index < input.length
      return false if yield(input[index]) == false

      index += 1
    end
    output
  end

  def my_any?(input, index = 0)
    output = false
    unless block_given?
      while index < input.length
        return true if input[index] == true

        index += 1
      end
    end
    while index < input.length
      return true if yield(input[index]) == true

      index += 1
    end
    output
  end

  def my_none?(input, index = 0)
    output = true
    unless block_given?
      while index < input.length
        return false if input[index] == true

        index += 1
      end
    end
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
# puts my_each_with_index([1, 2, 3, 4, 5, 6]) { |x| x * 3 }
# puts my_select([1, 2, 3, 4, 5, 6]) { |x| x >= 1 }
# puts my_all?([1, 2, 3, 4, 5, 6]) { |x| x <= 6 }
# puts my_any?([1, 2, 3, 4, 5, 6, 8]) { |x| x > 4 }
# puts my_none?([1, 2, 3, 4, 5, 6]) { |x| x > 5 }
# puts my_count([1, 2, 3, 4, 5, 6]) { |x| x >= 1 }
# puts my_map([1, 2, 3, 4, 5, 6]) { |x| x * x * x }

arr = [2, 2, 3, 4]

puts arr.my_each_with_index(0) { |x| x }
