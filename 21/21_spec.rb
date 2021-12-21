require 'rspec'
require './21a'
require './21bb'
require 'pry'
require 'pry-nav'

RSpec.describe 'Day 21' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(739785  )
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(855624)
  end

  it 'works with the test input for part 2' do
    expect(part_twos(ex_file)).to eq(444356092776315)
  end

  it 'works with main input for part 2' do
    expect(part_twos(main_file)).to eq(187451244607486)
  end
end
  