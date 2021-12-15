def part_one(file)
  builder = Builder.new(file, 10)
  builder.build
end

def part_two(file)
  builder = Builder.new(file, 40)
  builder.build
end

class Builder
  def initialize(file, days)
    @days = days
    @counts = {}
    parse_file(file)
  end

  def build
    counts = Hash.new(0)
    final_counts = Hash.new(0)
    @template.chars.each { |c| final_counts[c] += 1 }
    @template.chars.each_cons(2) { |pair| counts[pair.join('')] += 1 }

    @days.times do
      new_counts = Hash.new(0)
      counts.each do |k,v|
        next if v == 0
        @rules[k][:results].each do |pair|
          new_counts[pair] += v
        end
        final_counts[@rules[k][:insert]] += v
      end
      counts = new_counts
    end

    final_counts.values.max - final_counts.values.min
  end

  def parse_file(file)
    lines = File.readlines(file, chomp: true)
    @template = lines.first
    @rules = lines.each_with_object({}) do |line, obj|
      next unless line.include?('->')
      rule = line.split(' -> ')
      @counts[rule[0]] = 0
      obj[rule[0]] = {
        insert: rule[1],
        results: [rule[0][0]+rule[1], rule[1]+rule[0][1]],
      }
    end
  end
end
