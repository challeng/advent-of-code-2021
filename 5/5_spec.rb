require 'rspec'
require './5'
require 'pry'

RSpec.describe 'Day 5' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(5)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(6311)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(12)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(19929)
  end
end
  