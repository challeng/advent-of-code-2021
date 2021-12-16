require 'rspec'
require './16a'
require './16b'
require 'pry'
require 'pry-nav'

RSpec.describe 'Day 16' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one('D2FE28')).to eq(6)
  end

  it 'works with the test input for part 1' do
    expect(part_one('38006F45291200')).to eq(9)
  end

  it 'works with main input for part 1' do
    expect(part_one('EE00D40C823060')).to eq(14)
  end

  it 'works with main input for part 1' do
    expect(part_one('8A004A801A8002F478')).to eq(16)
  end

  it 'works with main input for part 1' do
    expect(part_one('620080001611562C8802118E34')).to eq(12)
  end

  it 'works with main input for part 1' do
    expect(part_one('C0015000016115A2E0802F182340')).to eq(23)
  end

  it 'works with main input for part 1' do
    expect(part_one('A0016C880162017C3686B18A3D4780')).to eq(31)
  end

  xit 'works with main input for part 1' do
    expect(part_one(main_file, file: true)).to eq(0)
  end

  # it 'works with the test input for part 2' do
  #   expect(part_two(ex_file)).to eq(0)
  # end

  # it 'works with main input for part 2' do
  #   expect(part_two(main_file)).to eq(0)
  # end
end
  