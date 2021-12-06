def part_one(file)
  fish_count(file, 80)
end

def part_two(file)
  fish_count(file, 256)
end

def fish_count(file, days)
  fish = File.readlines(file)[0].chomp.split(',').map(&:to_i)
  counts = fish.group_by {|f| f}.transform_values { |val| val.count}
  days.times { counts = counts_after_day(counts) }
  counts.values.sum
end

def counts_after_day(counts)
  counts.each_with_object(Hash.new(0)) do |(fish, count), new_counts|
    if fish == 0
      new_counts[6] += count
      new_counts[8] += count
    else
      new_counts[fish -1 ] += count
    end
  end
end
