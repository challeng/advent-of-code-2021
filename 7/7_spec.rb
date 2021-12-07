require 'rspec'
require './7'
require 'pry'

RSpec.describe 'Day 7' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(37)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(345035)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(168)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(97038163)
  end
end
  