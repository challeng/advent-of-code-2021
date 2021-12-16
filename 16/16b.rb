def part_two(file)
  runner = RunnerB.new(file)
end

class RunnerB
  def initialize(file)
    parse_file(file)
  end

  def parse_file(file)
    File.readlines(file, chomp: true).each_with_index do |line, i|
    end
  end
end
  