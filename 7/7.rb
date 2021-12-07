def part_one(file)
  min_fuel(file, ->(start, finish) { (start - finish).abs })
end

def part_two(file)
  min_fuel(file, ->(start, finish) { (1..(start - finish).abs).sum })
end

def min_fuel(file, fuel_cost_between)
  inputs = File.readlines(file).first.split(',').map(&:to_i)
  (inputs.min..inputs.max).each_with_object({}) do |spot, fuel_at|
    fuel_at[spot] = inputs.sum { |input| fuel_cost_between.call(input, spot) }
  end.values.min
end
