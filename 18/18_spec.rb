require 'rspec'
require './18a'
require './18b'
require 'pry'
require 'pry-nav'
require 'json'

RSpec.describe 'Day 18' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(sum('ex_input_1.txt')).to eq([[[[0,7],4],[[7,8],[6,0]]],[8,1]])
  end

  it 'works with the test input for part 1' do
    expect(sum('ex_input.txt')).to eq([[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]])
  end

  it 'works with input p1' do
    expect(part_one('ex_input.txt')).to eq(4140)
  end

  describe '#magnitude' do
    it 'works' do
      expect(magnitude([[1,2],[[3,4],5]])).to eq 143
    end
    it 'works' do
      expect(magnitude([[[[0,7],4],[[7,8],[6,0]]],[8,1]])).to eq 1384
    end
    it 'works' do
      expect(magnitude([[[[1,1],[2,2]],[3,3]],[4,4]])).to eq 445
    end
    it 'works' do
      expect(magnitude([[[[3,0],[5,3]],[4,4]],[5,5]])).to eq 791
    end
    it 'works' do
      expect(magnitude([[[[5,0],[7,4]],[5,5]],[6,6]])).to eq 1137
    end
    it 'works' do
      expect(magnitude([[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]])).to eq 3488
    end
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(4207)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(3993)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(4635)
  end
end
  