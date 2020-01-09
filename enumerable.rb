# frozen_string_literal: true

# rubocop: disable Metrics/PerceivedComplexity,
# rubocop: disable Metrics/CyclomaticComplexity

# doc comment custom enumerable methods
module Enumerable
  def my_each(_proc = nil)
    return to_enum unless block_given?

    for index in self # rubocop:disable Style/For
      yield(index)
    end
    self
  end

  def my_each_with_index(_proc = nil)
    return to_enum unless block_given?

    for index in (0...size) # rubocop:disable Style/For
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

    counter
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    output = []
    if !proc
      my_each { |x| output.push(yield x) }
    else
      my_each { |x| output.push(proc.call(x)) }
    end
    output
  end

  def my_inject(*parameter)
    return to_enum if !block_given? && parameter[0].eql?(Symbol)

    if parameter.size.eql?(1) && parameter[0].is_a?(Numeric)
      memo = parameter[0]
      my_each { |x| memo = yield(memo, x) }
    elsif parameter.size.eql?(1) && parameter[0].is_a?(Symbol)
      memo = first
      my_each_with_index { |x, i| memo = memo.send(parameter[0], x) unless i.eql?(0) }
    elsif parameter.size.eql?(2) && parameter[0].is_a?(Numeric) && parameter[1].instance_of?(Symbol)
      memo = parameter[0]
      my_each { |x| memo = memo.send(parameter[1], x) }
    elsif parameter.size.eql?(0) && block_given?
      memo = first
      my_each_with_index { |x, i| memo = yield(memo, x) unless i.eql?(0) }
    else puts 'Incorrect parameters input'
    end
    memo
  end

  def multiply_els
    my_inject { |sum, n| sum * n }
  end
end

# rubocop: enable Metrics/PerceivedComplexity,
# rubocop: enable Metrics/CyclomaticComplexity
