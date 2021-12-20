def part_one(file)
  enhancer = Enhancer.new(file)
  2.times { enhancer.enhance }
  enhancer.lit_count
end

def part_two(file)
  enhancer = Enhancer.new(file)
  50.times { enhancer.enhance }
  enhancer.lit_count
end

class Enhancer
  def initialize(file)
    parse_file(file)
    @enhance_count = 0
  end

  def lit_count
    @image.values.count {|v| v == '#'}
  end

  def enhance
    new_image = Hash.new(default_char)
    (@min_x..@max_x).each do |x|
      (@min_y..@max_y).each do |y|
        new_image[[x,y]] = convert(x,y)
      end
    end
    @image = new_image 
    set_min_maxs
    @enhance_count += 1
  end

  def default_char
    alternate = @algo[(['.']*9).map {|el| el == '.' ? 0 : 1 }.join('').to_i(2)]
    @enhance_count.even? ? alternate : '.'
  end

  def convert(x,y)
    number = nines(x,y).map {|xy| @image[xy] == '.' ? 0 : 1 }.join('').to_i(2)
    @algo[number] 
  end

  def nines(x,y)
    [[x-1,y-1],[x,y-1],[x+1,y-1],[x-1,y],[x,y],[x+1,y],[x-1,y+1],[x,y+1],[x+1,y+1]]
  end

  def set_min_maxs
    @min_x = @image.keys.map{|k| k[0]}.min - 4
    @max_x = @image.keys.map{|k| k[0]}.max + 4
    @min_y = @image.keys.map{|k| k[1]}.min - 4
    @max_y = @image.keys.map{|k| k[1]}.max + 4
  end

  def parse_file(file)
    lines = File.readlines(file, chomp: true)
    @image = Hash.new('.')
    @algo = lines[0].chars
    lines[2..-1].each_with_index do |line, yi|
      line.chars.each_with_index do |char, xi|
        @image[[xi,yi]] = char
      end
    end
    set_min_maxs
  end
end




