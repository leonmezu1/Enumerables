# frozen_string_literal: true

# rubocop: disable Metrics/ModuleLength
# doc comment
module Enumerable
  def my_each
    return to_enum unless block_given?

    length.times do |index|
      yield self[index]
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    length.times do |index|
      yield(self[index], index)
    end
    self
  end

  def my_select(index = 0)
    return to_enum unless block_given?

    output = []
    range = length - index
    range.times do
      output.push(self[index]) if yield(self[index])
      index += 1
    end
    output
  end

  def class_pat_or_eql(inspected, pattern)
    (inspected.respond_to?(:is_a?) && inspected.eql?(pattern)) ||
      (pattern.is_a?(Class) && inspected.is_a?(pattern)) ||
      (pattern.is_a?(Regexp) && pattern.match(inspected))
  end

  def my_all?
    index = 0
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

  def my_any?
    index = 0
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

  def my_none?
    index = 0
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
        counter += 1 if self[index] == aux
        index += 1
      end
      return "#{counter} warning: given block not used"
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

  def my_map
    return self unless block_given?

    index = 0
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

# rubocop: enable Metrics/ModuleLength

print [1, 2, 3, 4, 5, 6].each
puts "\n"
print [1, 2, 3, 4, 5, 6].my_each
# puts [1, 2, 3, 4, 5, 6].my_each_with_index(2) { |x| x * 3 }
# puts [1, 2, 3, 4, 5, 6].my_select { |x| x >= 4 }
# puts [1, 2, 3, 4, 5, 6].my_all? { |x| x <= 6 }
# puts [1, 2, 3, 4, 5, 6, 8].my_any?(2) { |x| x > 8 }
# puts [false, false].my_none?
# puts [1, 2, 3, 4, 5, 6].my_count(3) { |x| x >= 5 }
# puts [1, 2, 3, 4, 5, 6].my_map(3) { |x| x * x }

# arr = [/m/, 1, 1, 1, 2]

# puts arr.my_inject(1) { |sum, n| sum + n }
# puts arr.inject(1) { |sum, n| sum + n }

# puts arr.my_each(2)
# puts arr.my_count(1) { |x| x > 1 }
# puts arr.count(1) { |x| x > 1 }

# puts arr.my_each { |x| x * 3 }

# puts arr.respond_to?(:Array)

# print %w[abnt abnt abnt].all?('abnt')
