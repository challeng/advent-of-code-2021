require 'rspec'
require './6'
require 'pry'

RSpec.describe 'Day 6' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(5934)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(386755)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(26984457539)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(1732731810807)
  end
end
  