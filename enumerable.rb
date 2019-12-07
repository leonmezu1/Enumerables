# frozen_string_literal: true

# rubocop: disable Metrics/ModuleLength
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
  # rubocop: disable Metrics/PerceivedComplexity
  # rubocop: disable Metrics/CyclomaticComplexity
  # rubocop: disable Metrics/AbcSize

  def my_count(aux = nil)
    index = 0
    counter = 0
    if block_given? && aux.nil?
      while index < length
        counter += 1 if yield(self[index]) == true
        index += 1
      end
    elsif block_given? && !aux.nil?
      while index < length
        counter += 1 if self[index] == aux # && yield(self[index]) == true
        index += 1
      end
      return "#{counter} 'warning: given block not used'"
    elsif !block_given? && aux.nil?
      return length
    else
      while index < length
        counter += 1 if self[index] == aux
        index += 1
      end
    end
    counter
  end

  # rubocop: enable Metrics/PerceivedComplexity
  # rubocop: enable Metrics/CyclomaticComplexity
  # rubocop: enable Metrics/AbcSize

  def my_map(index = 0)
    return self unless block_given?

    output = []
    range = length - index
    range.times do
      output.push(yield(self[index]))
      index += 1
    end
    output
  end

  def my_inject(aux = 0)
    return self if length < 2

    accumulator = yield(yield(self[0], aux), self[1])
    if length > 2
      i = 2
      length - 2.times do
        accumulator = yield(accumulator, self[i])
        i += 1
      end
    end
    accumulator
  end
end

# rubocop: enable Metrics/MethodLength
# rubocop: enable Metrics/ModuleLength

# puts my_each([1, 2, 3, 4, 5, 6], 3) { |x| x * 3 }
# puts [1, 2, 3, 4, 5, 6].my_each_with_index(2) { |x| x * 3 }
# puts [1, 2, 3, 4, 5, 6].my_select { |x| x >= 4 }
# puts [1, 2, 3, 4, 5, 6].my_all? { |x| x <= 6 }
# puts [1, 2, 3, 4, 5, 6, 8].my_any?(2) { |x| x > 8 }
# puts [false, false].my_none?
# puts [1, 2, 3, 4, 5, 6].my_count(3) { |x| x >= 5 }
# puts [1, 2, 3, 4, 5, 6].my_map(3) { |x| x * x }

arr = [1, 1, 1, 1, 2]

# puts arr.my_inject(1) { |sum, n| sum + n }
# puts arr.inject(1) { |sum, n| sum + n }

puts arr.count(1)
puts arr.my_count(1)
