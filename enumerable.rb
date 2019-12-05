include Enumerable

# frozen_string_literal: true

# doc comment
module Enumerable
  def my_each(input)
    i = 0
    output = []
    range = input.length
    range.times do
      output.push(yield(input[i]))
      i += 1
    end
    output
  end

  def my_each_with_index
    nil
  end

  def my_select
    nil
  end

  def my_all?
    nil
  end

  def my_any?
    nil
  end

  def my_none?
    nil
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
end

puts my_each([1, 2, 3, 4, 5, 6]) { |x| x * 3 }
