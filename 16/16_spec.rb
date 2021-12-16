require 'rspec'
require './16a'
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

  it 'works with the test input for part 2' do
    expect(part_two('C200B40A82')).to eq(3)
  end

  it 'works with the test input for part 2' do
    expect(part_two('04005AC33890')).to eq(54)
  end

  it 'works with the test input for part 2' do
    expect(part_two('880086C3E88112')).to eq(7)
  end

  it 'works with the test input for part 2' do
    expect(part_two('CE00C43D881120')).to eq(9)
  end

  it 'works with the test input for part 2' do
    expect(part_two('D8005AC2A8F0')).to eq(1)
  end

  it 'works with the test input for part 2' do
    expect(part_two('F600BC2D8F')).to eq(0)
  end

  it 'works with the test input for part 2' do
    expect(part_two('9C005AC2F8F0')).to eq(0)
  end

  it 'works with the test input for part 2' do
    expect(part_two('9C0141080250320F1802104A08')).to eq(1)
  end

  xit 'works with main input for part 2' do
    expect(part_two(main_file, file: true)).to eq(3408662834145)
  end
end
  