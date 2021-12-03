require 'rspec'
require './3'
require 'pry'

RSpec.describe 'Day 3' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(198)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(1092896)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(230)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(4672151)
  end
end
  