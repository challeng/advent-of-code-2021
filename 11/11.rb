def part_one(file)
  flasher = Flasher.new(file)
  flasher.flashes(100)
end

def part_two(file)
  flasher = Flasher.new(file)
  flasher.find_sync
end

class Flasher
  attr_reader :grid

  def initialize(file)
    @grid = parse_file(file)
  end

  def flashes(days)
    days.times do
      grid.next_day
    end
    grid.flashes
  end

  def find_sync
    count = 0
    loop do
      count += 1
      grid.next_day
      return count if grid.synced?
    end 
  end

  def parse_file(file)
    grid_hash = {}
    File.readlines(file, chomp: true).each_with_index do |line, y|
      line.split('').each_with_index { |num, x| grid_hash[[x,y]] = num.to_i }
    end
    Grid.new(grid_hash)
  end
end
  
class Grid
  attr_accessor :grid, :flashes

  def initialize(grid)
    @grid = grid
    @flashes = 0
  end

  def next_day
    grid.transform_values! { |v| increase(v) }
    flash! 
    grid.transform_values! { |v| v == '.' ? 0 : v }
  end

  def flash!
    grid.keys.each do |x,y|
      next unless grid[[x,y]] == '*'
      self.flashes += 1
      grid[[x,y]] = '.'
      neighbors(x,y).each { |nx,ny| grid[[nx,ny]] = increase(grid[[nx,ny]]) }
      flash!
    end
  end

  def synced?
    grid.values.all? {|v| v == 0}
  end

  def neighbors(x,y)
    [[x+1,y],[x-1,y],[x,y+1],[x,y-1],[x-1,y-1],[x-1,y+1],[x+1,y-1],[x+1,y+1]].select { |x,y| grid[[x,y]].is_a?(Integer) }
  end

  def increase(val)
    val+1 == 10 ? '*' : val+1
  end

  def printit
    10.times do |y|
      10.times do |x|
        print grid[[x,y]]
      end
      puts
    end
    puts
  end
end