def part_one(file)
  launcher = Launcher.new(file)
  launcher.find_max_height
end

def part_two(file)
  launcher = Launcher.new(file)
  launcher.find_distinct_vels
end

class Launcher
  def initialize(file)
    parse_file(file)
  end

  def find_max_height
   find_all_trajectories.map {|h| h[:height] }.max
  end

  def find_distinct_vels
    find_all_trajectories.count
  end

  def find_all_trajectories
    heights = []

    (1..@target_xs[1]).each do |x|
      (-300..300).each do |y|
        vel = [x,y]
        max_height = launch([0,0], vel)
        heights << {height: max_height, vel: vel} if max_height && heights.none? {|h| h[:vel] == vel }
      end
    end

    heights
  end

  def launch(pos, vel)
    max_height = nil
    heights = []

    loop do
      heights << pos[1]
      pos, vel = step(pos,vel)
      if in_target_area?(pos)
        max_height = heights.max
        break
      end
      break if past_target_area?(pos)
    end

    max_height
  end

  def past_target_area?(pos)
    pos[0] > @target_xs.max || pos[1] < @target_ys.min
  end

  def in_target_area?(pos)
    (@target_xs[0]..@target_xs[1]).include?(pos[0]) &&
      (@target_ys[0]..@target_ys[1]).include?(pos[1])
  end

  def step(pos, vel)
    pos = [pos[0] + vel[0], pos[1] + vel[1]]
    xvel = if vel[0] < 0
             vel[0] + 1
           elsif vel[0] > 0
             vel[0] - 1
           else
             vel[0]
           end
    vel = [xvel, vel[1] - 1]
    [pos, vel]
  end

  def parse_file(file)
    line = File.readlines(file, chomp: true).first
    @target_xs = line.gsub(',','').split(' ')[2][2..-1].split('..').map(&:to_i) 
    @target_ys = line.split(' ')[3][2..-1].split('..').map(&:to_i)
  end
end
  