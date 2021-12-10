require 'rspec'
require './10'
require 'pry'

RSpec.describe 'Day 10' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(26397)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(318099)
  end

  # it 'works with the test input for part 2' do
  #   expect(part_two(ex_file)).to eq(0)
  # end

  # it 'works with main input for part 2' do
  #   expect(part_two(main_file)).to eq(0)
  # end
end
  