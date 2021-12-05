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
    points = []
    x_dir = start.x < finish.x ? '+' : '-'
    y_dir = start.y < finish.y ? '+' : '-'

    x = start.x
    y = start.y

    while(x != finish.x && y != finish.y) do
      points << Point.new(x,y)
      x = x.send(x_dir, 1) if x != finish.x
      y = y.send(y_dir, 1) if y != finish.y
    end

    points << Point.new(x,y)
  end

  def vertical?
    start.x == finish.x
  end

  def horizontal?
    start.y == finish.y
  end

  def diagonal?
    !vertical? && !horizontal?
  end
end

class Grid
  attr_reader :grid

  def initialize
    @grid = Hash.new(0)
  end

  def count_intersections(times)
    count = 0
    grid.values.each do |val|
      count += 1 if val >= times
    end

    count 
  end

  def draw_line(line)
    if line.vertical?
      draw_vertical(line)
    elsif line.horizontal?
      draw_horizontal(line)
    else
      draw_diagonal(line)
    end
  end

  def draw_vertical(line)
    range_start = [line.start.y, line.finish.y].min
    range_end = [line.start.y, line.finish.y].max
    (range_start..range_end).each do |n|
      mark_point(line.start.x, n)
    end
  end

  def draw_horizontal(line)
    range_start = [line.start.x, line.finish.x].min
    range_end = [line.start.x, line.finish.x].max
    (range_start..range_end).each do |n|
      mark_point(n, line.start.y)
    end
  end

  def draw_diagonal(line)
    line.points.each { |p| mark_point(p.x, p.y) }
  end

  def mark_point(x,y)
    grid[[x,y]] += 1
  end
end


  # def printit
  #   10.times do |y|
  #     10.times do |x|
  #       print(grid[[x,y]])
  #     end
  #     puts
  #   end
  # end