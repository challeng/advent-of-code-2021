def part_one(file)
  smoke_flow = SmokeFlow.new(file)
  smoke_flow.risk_level
end

def part_two(file)
  smoke_flow = SmokeFlow.new(file)
  lengths = smoke_flow.basins.map(&:length).sort.reverse
  lengths[0] * lengths[1] * lengths[2]
end

class SmokeFlow
  attr_reader :heights, :max_x, :max_y

  def initialize(file)
    parse_file(file)
  end

  def basins
    low_points.map {|x,y| basin_from(x,y)}
  end

  def basin_from(x,y)
    valid_points = surrounding_basin_points(x,y,[])
    basin = [[x,y]] + valid_points
    while(valid_points.length > 0) do
      valid_points = valid_points.reduce([]) do |next_batch, (nx,ny)| 
        next_batch += surrounding_basin_points(nx,ny,basin)
        basin += surrounding_basin_points(nx,ny,basin)
        next_batch
      end
    end
    basin 
  end

  def surrounding_basin_points(x,y,basin)
    surrounding_points(x,y).select do |spx, spy|
      heights[[x,y]] < heights[[spx,spy]] &&
        !basin.include?([spx,spy]) &&
        heights[[spx,spy]] != 9
    end
  end

  def surrounding_points(x,y)
    [[x-1,y], [x+1,y], [x,y-1], [x,y+1]].select { |x,y| heights[[x,y]] }
  end

  def risk_level
    low_points.map{|x,y| heights[[x,y]]}.sum { |lp| lp + 1 }  
  end

  def low_points
    low_points = []
    (0..max_y).each do |y|
      (0..max_x).each do |x|
        low_points << [x,y] if surrounding_points(x,y).all? {|spx, spy| heights[[x,y]] < heights[[spx,spy]]}
      end
    end
    low_points
  end

  def parse_file(file)
    lines = File.readlines(file, chomp: true)
    @heights = {}
    @max_y = lines.length - 1
    @max_x = lines[0].length - 1
    lines.each_with_index do |line, y|
      nums = line.split('').map(&:to_i)
      nums.each_with_index { |num, x| heights[[x,y]] = num }
    end
  end
end
  