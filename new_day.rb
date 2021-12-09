day = ARGV[0]
system("mkdir #{day}")
File.open("#{day}/#{day}.rb", "w") do |f|     
  f.write("""def part_one(file)
  runner = Runner.new(file)
end

def part_two(file)
  runner = Runner.new(file)
end

class Runner
  attr_reader :results

  def initialize(file)
    parse_file(file)
  end

  def parse_file(file)
    File.readlines(file, chomp: true)
  end
end
  """)
end
File.open("#{day}/#{day}_spec.rb", "w") do |f|     
  f.write("""require 'rspec'
require './#{day}'
require 'pry'

RSpec.describe 'Day #{day}' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(0)
  end

  it 'works with main input for part 1' do
    expect(part_one(main_file)).to eq(0)
  end

  it 'works with the test input for part 2' do
    expect(part_two(ex_file)).to eq(0)
  end

  it 'works with main input for part 2' do
    expect(part_two(main_file)).to eq(0)
  end
end
  """)
end
system("touch #{day}/ex_input.txt")
system("touch #{day}/input.txt")