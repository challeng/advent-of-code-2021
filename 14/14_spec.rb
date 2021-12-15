require 'rspec'
require './14'
require 'pry'

RSpec.describe 'Day 14' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(1588)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(3284)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(2188189693529)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(4302675529689)
  end
end
  