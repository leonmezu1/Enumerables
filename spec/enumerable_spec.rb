# frozen_string_literal: true

require './enumerable.rb'

RSpec.describe 'Enumerables' do
  let(:unitary) { [1] }
  let(:arr0) { [0, 0, 1] }
  let(:arr1) { [1, 2, 3, 4, 5] }
  let(:arr2) { [true, 'all', 'string', 0.2, 0.578, 'max'] }
  let(:arr3) { %w[word again a word] }
  let(:arr4) { [true, false] }
  let(:arr5) { (1..10) }
  let(:arr6) { [false, false] }
  let(:test_hash) { { first: 'one' } }

  describe '#my_each' do
    it 'returns to enumerator if a block is not given' do
      expect(arr0.my_each).to be_a(Enumerator)
    end

    it 'returns the same object items if no further instruction is given' do
      expect(arr0.my_each { |item| item }).to eq(arr0)
    end

    it "iterates over an object and doesn't modify the original iterable" do
      expect(unitary.my_each { |item| print "this is the item: #{item}" }).to eq(unitary)
    end

    it 'ignores procs' do
      test_proc = proc { |item| item + 2 }
      expect(arr0.my_each(&test_proc)).to eq(arr0)
    end
  end

  describe '#my_each_with_index' do
    it 'returns to enumerator if no block if given' do
      expect(arr1.my_each_with_index).to be_a(Enumerator)
    end

    it 'ignores procs' do
      test_proc = proc { |item| item + 2 }
      expect(arr1.my_each_with_index(&test_proc)).to eq(arr1)
    end

    it "returns an iterable object with it's elements indexes, it doesn't modify the original iterable" do
      expect(arr1.my_each_with_index { |item, i| p "this is #{item} and #{i}" }).to eq(arr1)
    end

    it 'returns the same object items if no further instruction is given' do
      expect(arr1.my_each_with_index { |item, i| }).to eq(arr1)
    end
  end

  describe '#my_select' do
    it 'creates a new array according to the given block' do
      expect(arr2.my_select { |item| item.is_a?(Numeric) }).to eq([0.2, 0.578])
    end

    context 'given a block' do
      it { expect(arr1.my_select { |item| item > 2 }).to eq([3, 4, 5]) }
      it { expect(arr1.my_select { |item| item < 2 }).to eq([1]) }
      it { expect(arr1.my_select { |item| item == 2 }).to eq([2]) }
    end

    it 'returns to enumerator if no block is given' do
      expect(arr2.my_select).to be_a(Enumerator)
    end

    it 'accepts more than one parameter' do
      expect(test_hash.my_select { |x, y| x != y }).to eq([[:first, 'one']])
    end
  end

  describe '#my_all?' do
    it 'returns true if all the elements in the enumerable object are true or truthy' do
      expect(arr2.my_all?).to be(true)
    end

    it 'returns false if any of the elements is false' do
      expect(arr4.my_all?).to be(false)
    end

    it 'returns false if any element is nil' do
      expect([true, true, nil].my_all?).to be(false)
    end

    it 'returns true if the block evaluation for every element is true' do
      expect(arr1.my_all? { |item| item > 0 }).to be(true)
    end

    context 'returns false if the block evaluation for any element is false' do
      it { expect(arr1.my_all? { |item| item > 1 }) }
    end

    it 'allows range evaluations' do
      expect(arr5.my_all? { |item| item > 0 }).to be(true)
    end

    it 'allows string arrays evaluations' do
      expect(arr3.my_all? { |item| !item.empty? }).to be(true)
    end

    it 'returns true if all the elements are equal or match to the given value ~ variable' do
      expect(arr6.my_all?(false)).to be(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if any of the elements in the enumerable object are true or truthy' do
      expect(arr2.my_any?).to be(true)
    end

    it 'returns false if none of the elements is true' do
      expect(arr6.my_any?).to be(false)
    end

    it 'returns true if the block evaluation for any element is true' do
      expect(arr1.my_any? { |item| item > 0 }).to be(true)
    end

    context 'returns false if the block evaluation for every element is false' do
      it { expect(arr1.my_any? { |item| item > 1 }) }
    end

    it 'allows range evaluations' do
      expect(arr5.my_any? { |item| item > 0 }).to be(true)
    end

    it 'allows string arrays evaluations' do
      expect(arr3.my_any? { |item| item.eql?('a') }).to be(true)
    end

    it 'returns true if any of the elements are equal or matches to the given value ~ variable' do
      expect(arr2.my_any?(0.2)).to be(true)
    end
  end

  describe '#my_none?' do
    it 'returns true if all of the elements in the enumerable object are false' do
      expect(arr6.my_none?).to be(true)
    end

    it 'returns false if any of the elements is true' do
      expect(arr4.my_none?).to be(false)
    end

    it 'returns true if the block evaluation for all the elements is false' do
      expect(arr0.my_none? { |item| item > 2 }).to be(true)
    end

    context 'returns false if the block evaluation for every element is true' do
      it { expect(arr0.my_none? { |item| item >= 0 }) }
    end

    it 'allows range evaluations' do
      expect(arr5.my_none? { |item| item > 10 }).to be(true)
    end

    it 'allows string arrays evaluations' do
      expect(arr3.my_none? { |item| item.eql?('non_existing') }).to be(true)
    end

    it 'returns true if none the elements are equals or matches to the given value ~ variable' do
      expect(arr1.my_none?(6)).to be(true)
    end
  end

  describe '#my_count' do
    it 'returns the count of the element of the object if no block is given' do
      expect(arr1.my_count).to eq(5)
    end

    it 'returns the count of the element that fulfill the block conditions' do
      expect(arr1.my_count { |item| item > 5 }).to eq(0)
    end

    it 'returns the count of the element that are equal or matches the given value ~ variable' do
      expect(arr3.my_count('word')).to eq(2)
    end

    it 'returns the count of the element that fulfill conditions given a proc' do
      pro = proc { |item| item.include?('w') }
      expect(arr3.my_count(&pro)).to eq(2)
    end
  end

  describe '#my_map' do
    it 'returns an enumerator if no block is given' do
      expect(arr1.my_map).to be_a(Enumerator)
    end

    it 'returns a new object according the given block specifications' do
      expect(arr1.my_map { |item| item + 1 }).to eq([2, 3, 4, 5, 6])
    end

    it 'returns a new object according specifications if a proc is given' do
      pro = proc { |item| item * 2 }
      expect(arr1.my_map(&pro)).to eq([2, 4, 6, 8, 10])
    end
  end

  describe '#my_inject' do
    it 'returns the accumulate of certain algebraic operation' do
      expect(arr1.my_inject(:+)).to eq(15)
    end

    it 'returns the accumulate of certain algebraic operation with an initial accumulator' do
      expect(arr1.my_inject(3, :+)).to eq(18)
    end

    context 'accumulate of other algebraic operations' do
      it { expect(arr1.my_inject(:-)).to eq(-13) }
      it { expect(arr1.my_inject(:*)).to eq(120) }
      it { expect(arr1.my_inject(:/)).to eq(0) }
    end

    it 'returns to enumerator if no block, proc or a validad algebraic symbol op is given' do
      expect(arr4.my_inject).to be_a(Enumerator)
    end

    it 'returns an operation on each element of the object given a block ~ proc' do
      block = proc { |prod, n| prod + n }
      expect(arr1.my_inject(&block)).to eq(arr1.inject(&block))
    end
  end

  describe '#multiply_els' do
    it 'returns the result of all the elements multiplied together' do
      expect([2, 2, 2].multiply_els).to eq(8)
    end
  end
end
