# frozen_string_literal: true

require './enumerable.rb'

RSpec.describe 'Enumerables' do
  let(:unitary) { [1] }
  let(:arr0) { [0, 0, 1] }
  let(:arr1) { [1, 2, 3, 4, 5] }
  let(:arr2) { [true, 'all', string, 0.2, 0.578, 'max'] }
  let(:arr3) { %w[lword again a word] }
  let(:arr4) { [false, false] }
  let(:arr5) { (1..10) }

  describe '#my_each' do
    it 'returns to enumerator if a block is not given' do
      expect(arr0.my_each).to be_a(Enumerator)
    end

    it 'returns the same object items if no further instruction is given' do
      expect(arr0.my_each { |item| item }).to eq(arr0)
    end

    it 'iterates over an object' do
      expect(unitary.my_each { |item| print "this is the item: #{item}" }).to eq(unitary)
    end

    it 'ignores procs' do
      test_proc = proc { |x| x + x }
      expect(arr0.my_each(&test_proc)).to eq(arr0)
    end
  end

  describe '#my_each_with_index' do
    it 'returns to enumerator if no block if given' do
      # statement
    end
  end

  describe '#my_each' do
    it '' do
      # statement
    end
  end

  describe '#my_each' do
    it '' do
      # statement
    end
  end

  describe '#my_each' do
    it '' do
      # statement
    end
  end

  describe '#my_each' do
    it '' do
      # statement
    end
  end

  describe '#my_each' do
    it '' do
      # statement
    end
  end

  describe '#my_each' do
    it '' do
      # statement
    end
  end

  describe '#my_each' do
    it '' do
      # statement
    end
  end
end
