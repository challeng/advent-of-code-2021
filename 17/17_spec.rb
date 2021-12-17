require 'rspec'
require './17a'
require 'pry'
require 'pry-nav'

RSpec.describe 'Day 17' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(45)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(7875)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(112)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(2321)
  end
end
  