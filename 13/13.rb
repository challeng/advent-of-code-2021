def part_one(file)
  decoder = Decoder.new(file)
  decoder.run_one_fold
end

def part_two(file)
  decoder = Decoder.new(file)
  decoder.all_folds
end

class Decoder
  attr_reader :results

  def initialize(file)
    parse_file(file)
  end

  def run_one_fold
    dir,num = @folds.first
    num = num.to_i

    dir == 'y' ? fold_y(num) : fold_x(num)

    @grid.values.count
  end

  def all_folds
    @folds.each do |dir, num|
      dir == 'y' ? fold_y(num.to_i) : fold_x(num.to_i)
    end
  end

  def fold_x(num)
    max_width = num * 2
    grid_to_change = @grid.select {|k,v| k[0] > num}
    grid_to_change.each do |(x,y), _v|
      @grid.delete([x,y])
      new_x = max_width - x
      @grid[[new_x,y]] = '#'
    end
  end

  def fold_y(num)
    max_height = num * 2
    grid_to_change = @grid.select {|k,v| k[1] > num}
    grid_to_change.each do |(x,y), _v|
      new_y = max_height - y
      @grid[[x,new_y]] = '#'
      @grid.delete([x,y])
    end
  end

  def parse_file(file)
    @grid = Hash.new('.')
    @folds = []
    File.readlines(file, chomp: true).each do |line|
      if line.start_with?('fold')
        @folds << line.split(' ').last.split('=')
      else
        x,y = line.split(',').map(&:to_i)
        next unless x
        @grid[[x,y]] = '#'
      end
    end
  end

  def printit
    max_height = @grid.keys.map(&:last).max
    max_width = @grid.keys.map(&:first).max

    (0..max_height).each do |y|
      (0..max_width).each do |x|
        print @grid[[x,y]]
      end
      puts
    end
  end
end