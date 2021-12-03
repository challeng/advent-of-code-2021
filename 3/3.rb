def part_one(file)
  report = Report.new(file)
  report.gamma * report.epsilon
end

def part_two(file)
  report = Report.new(file)
  report.oxygen * report.co2
end

class Report
  attr_reader :binaries, :binaries_by_index

  def initialize(file)
    @binaries = parse_file(file)  
  end

  def gamma
    binaries.first.length.times.map do |i|
      nums_by_index = binaries.map { |binary| binary[i] }
      occurring_num(nums_by_index, tie: '1', comparer: '>')
    end
    .join
    .to_i(2)
  end

  def epsilon
    gamma.to_s(2).each_char.map do |char|
      char == "1" ? "0" : "1"
    end
    .join
    .to_i(2)
  end

  def oxygen
    filtered(tie: '1', comparer: '>')
  end

  def co2
    filtered(tie: '0', comparer: '<')
  end

  def filtered(tie:, comparer:)
    filtered_binaries = binaries
    i = 0

    while(filtered_binaries.length > 1) do
      nums_by_index = filtered_binaries.map { |binary| binary[i] }
      occurring_num = occurring_num(nums_by_index, tie: tie, comparer: comparer) 
      filtered_binaries = filtered_binaries.filter { |binary| binary[i] == occurring_num }
      i += 1
    end

    filtered_binaries.first.to_i(2)
  end

  def occurring_num(nums, tie:, comparer:)
    ones_count = nums.count { |num| num == '1' }
    zeroes_count = nums.length - ones_count

    if ones_count == zeroes_count
      tie
    else
      ones_count.send(comparer, zeroes_count) ? '1' : '0'
    end
  end

  def parse_file(file)
    File.readlines(file).each.map { |line| line.strip }
  end
end
  