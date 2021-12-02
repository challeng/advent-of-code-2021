require 'rspec'
require './2'

include DayTwo

RSpec.describe "Day 2" do
	let(:ex_file) { 'ex_input.txt' }
	let(:main_file) { 'input.txt' }

	it 'works with the test input for part 1' do
		expect(part_one(ex_file)).to eq(150)
	end

	it 'works with main input for part 1' do
		expect(part_one(main_file)).to eq(1694130)
	end

	it 'works with the test input for part 2' do
		expect(part_two(ex_file)).to eq(900)
	end

	it 'works with main input for part 2' do
		expect(part_two(main_file)).to eq(1698850445)
	end
end
