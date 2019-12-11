# frozen_string_literal: true

# rubocop: disable Metrics/PerceivedComplexity
# rubocop: disable Metrics/CyclomaticComplexity

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

  def my_select
    return to_enum unless block_given?

    output = []
    my_each { |x| output.push(x) if yield(x) }
    output
  end

  # Helper method for boolean return methods
  def inspect_method(item, c_p_v)
    (item.respond_to?(:eql?) && item.eql?(c_p_v)) ||
      (c_p_v.is_a?(Class) && item.is_a?(c_p_v)) ||
      (c_p_v.is_a?(Regexp) && item.respond_to?(:match) && item.match(c_p_v)) ||
      (c_p_v.eql?(nil) && item.eql?(nil))
  end

  def my_all?(aux = 'NonPrmts')
    output = true
    if block_given?
      my_each { |x| return false unless yield(x) }
    elsif !aux.eql?('NonPrmts')
      my_each { |x| return false unless inspect_method(x, aux) }
    elsif aux
      my_each { |x| return false unless x }
    end
    output
  end

  def my_any?(aux = 'NonPrmts')
    output = false
    if block_given?
      my_each { |x| return true if yield(x) }
    elsif !aux.eql?('NonPrmts')
      my_each { |x| return true if inspect_method(x, aux) }
    elsif aux
      my_each { |x| return true if x }
    end
    output
  end

  def my_none?(aux = 'NonPrmts')
    output = true
    if block_given?
      my_each { |x| return false if yield(x) }
    elsif !aux.eql?('NonPrmts')
      my_each { |x| return false if inspect_method(x, aux) }
    elsif aux
      my_each { |x| return false if x }
    end
    output
  end

  def my_count(aux = 'NonPrmts')
    counter = 0
    if !aux.eql?('NonPrmts')
      my_each { |x| counter += 1 if x.eql?(aux) }
    elsif block_given?
      my_each { |x| counter += 1 if yield(x) }
    end
    return length if !block_given? && aux.eql?('NonPrmts')

    puts counter, 'Hey llegue al final'
  end

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

# rubocop: enable Metrics/PerceivedComplexity
# rubocop: enable Metrics/CyclomaticComplexity

# print [1, 2, 3, 4, 5, 6].each
# puts "\n"
# print [1, 2, 3, 4, 5, 6].my_each
# puts [1, 2, 3, 4, 5, 6].my_each_with_index(2) { |x| x * 3 }
# puts [1, 2, 3, 4, 5, 6].my_select { |x| x >= 4 }
# puts [1, 2, 3, 4, 5, 6].my_all? { |x| x <= 6 }
# puts [1, 2, 3, 4, 5, 6, 8].my_any?(2) { |x| x > 8 }
# puts [false, false].my_none?
# puts [1, 2, 3, 4, 5, 6].my_count(3) { |x| x >= 5 }
# puts [1, 2, 3, 4, 5, 6].my_map(3) { |x| x * x }

# arr = %w[mandragora calm hamster]
# nilarr = [nil, nil, nil]
truearr = [true, true, true, 1]

# puts arr.my_inject(1) { |sum, n| sum + n }
# puts arr.inject(1) { |sum, n| sum + n }

# puts arr.my_each(2)
puts truearr.my_count
# puts truearr.my_count
puts truearr.count
# puts truearr.count

# puts arr.my_each { |x| x * 3 }

# puts arr.respond_to?(:Array)

# print %w[abnt abnt abnt].all?('abnt')

# puts arr.my_all?(String) { |x| x.length > 2 }
# puts arr.all?(String) { |x| x.length > 2 }
# puts truearr.my_all?(nil) # { |x| x.length > 7 }
# puts truearr.all?(nil) # { |x| x.length > 7 }
# puts arr.my_none?(20) # { |x| x.length > 10 }
# puts arr.none?(20) # { |x| x.length > 10 }
# print arr.my_any?('calm') # { |x| x.length > 7 }
# print arr.any?('calm') # { |x| x.length > 7 }
