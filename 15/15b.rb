def part_two(file)
  runner = RunnerB.new(file)
  runner.find_shortest_path
end

class RunnerB
  def initialize(file)
    @grid = {}
    @graph = {}
    @nodes = []
    parse_file(file)
  end

  def a_star(start, goal)
    opens = [start]
    came_from = {}
    g_score = Hash.new(Float::INFINITY)
    g_score[start] = 0
    f_score = Hash.new(Float::INFINITY)
    f_score[start] = h(start[0],start[1],goal[0],goal[1])

    while !opens.empty?
      current = opens.min {|a,b| f_score[a] <=> f_score[b]}

      if current == goal
        return reconstruct_path(came_from, current)
      end

      opens = opens - [current]
      neighbors(current[0],current[1]).each do |nxy|
        tentative_g_score = g_score[current] + @grid[nxy]
        if tentative_g_score < g_score[nxy]
          came_from[nxy] = current
          g_score[nxy] = tentative_g_score
          f_score[nxy] = tentative_g_score + h(nxy[0],nxy[1],goal[0],goal[1])
          if !opens.include?(nxy)
            opens << nxy
          end
        end
      end
    end
  end

  def reconstruct_path(came_from, current)
    total_path = [current]
    while came_from.keys.include?(current)
      current = came_from[current]
      total_path.prepend(current)
    end
    total_path
  end

  def find_shortest_path
    path = a_star([0,0],[(@max_x+1)*5-1,(@max_y+1)*5-1])
    path.sum {|coors| @grid[coors] } - @grid[[0,0]]
  end

  def h(x1,y1,x2,y2)
    (x2-x1).abs + (y2-y1).abs
  end

  def neighbors(x,y)
    [[x-1,y],[x+1,y],[x,y-1],[x,y+1]].select {|xy| @grid[xy] }
  end

  def parse_file(file)
    lines = File.readlines(file, chomp: true)
    @max_x = lines.first.length - 1
    @max_y = lines.count - 1
    lines.each_with_index do |line, y|
      line.chars.each_with_index do |c, x| 
        val = c.to_i

        5.times do |x_multi|
          5.times do |y_multi|
            risk_change = x_multi + y_multi
            new_x = x + (@max_x+1) * x_multi
            new_y = y + (@max_y+1) * y_multi

            new_val = val + risk_change
            new_val -= 9 if new_val > 9

            @grid[[new_x,new_y]] = new_val
          end
        end
      end
    end
    @end = [lines.first.length - 1, lines.count - 1]
    @size = lines.first.length * lines.count
  end
end
