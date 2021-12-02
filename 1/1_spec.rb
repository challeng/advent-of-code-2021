require 'rspec'
require './1'

include DayOne

RSpec.describe "Day 1" do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(7)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(1564)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(5)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(1611)
  end

  context 'with alternate solution' do
    it 'works with the test input for part 1' do
      expect(part_one_cons(ex_file)).to eq(7)
    end

    it 'works with main input for part 1' do
      expect(part_one_cons(main_file)).to eq(1564)
    end

    it 'works with the test input for part 2' do
      expect(part_two_cons(ex_file)).to eq(5)
    end

    it 'works with main input for part 2' do
      expect(part_two_cons(main_file)).to eq(1611)
    end
  end
end
