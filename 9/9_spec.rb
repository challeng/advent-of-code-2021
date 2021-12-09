require 'rspec'
require './9'
require 'pry'

RSpec.describe 'Day 9' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(15)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(600)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(1134)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(987840)
  end
end
  