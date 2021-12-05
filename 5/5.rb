def part_one(file)
  runner = Runner.new(file, skip_diags: true)
  runner.count_intersections(2) 
end

def part_two(file)
  runner = Runner.new(file)
  runner.count_intersections(2) 
end

class Runner
  attr_reader :lines, :grid, :skip_diags

  def initialize(file, skip_diags: false)
    @lines = parse_file(file)
    @grid = Grid.new
    @skip_diags = skip_diags
    draw_lines
  end

  def draw_lines
    lines.each do |line| 
      next if line.diagonal? && skip_diags
      grid.draw_line(line)
    end
  end

  def count_intersections(times)
    grid.count_intersections(times) 
  end

  def parse_file(file)
    File.readlines(file).map do |line|
      points = line.chomp.split(' -> ').map { |p| p.split(',').map(&:to_i) }
      Line.new(
        Point.new(points[0][0], points[0][1]),
        Point.new(points[1][0], points[1][1])
      )
    end
  end
end

Point = Struct.new(:x, :y)

class Line
  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def points
    x_dir = start.x < finish.x ? '+' : '-'
    y_dir = start.y < finish.y ? '+' : '-'
    x = start.x
    y = start.y

    yield Point.new(x,y)
    while(x != finish.x || y != finish.y) do
      x = x.send(x_dir, 1) if x != finish.x
      y = y.send(y_dir, 1) if y != finish.y
      yield Point.new(x,y)
    end
  end

  def diagonal?
    start.y != finish.y && start.x != finish.x
  end
end

class Grid
  attr_reader :grid

  def initialize
    @grid = Hash.new(0)
  end

  def count_intersections(times)
    grid.values.count { |val| val >= times}
  end

  def draw_line(line)
    line.points { |p| mark_point(p.x, p.y) }
  end

  def mark_point(x,y)
    grid[[x,y]] += 1
  end
end
