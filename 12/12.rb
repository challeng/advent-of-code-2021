def part_one(file)
  path_finder = PathFinder.new(file)
  path_finder.find_paths
end

def part_two(file)
  runner = Runner.new(file)
end

class PathFinder
  attr_reader :map, :paths

  def initialize(file)
    parse_file(file)
    @paths = []
  end

  def find_paths
    find('start', ['start'])  
    paths.count
  end

  def find(node, path)
    if node == 'end'
      paths << path #unless paths.include?(path)
      return
    end

    map[node].each do |dest|
      next if (path.include?(dest) && small_cave?(dest)) || path.last == 'end'
      find(dest, path + [dest])
    end
  end

  def small_cave?(dest)
    dest == dest.downcase 
  end

  def parse_file(file)
    @map = {}
    File.readlines(file, chomp: true).each do |line|
      start, finish = line.split('-') 
      @map[start] ||= []
      @map[start] << finish
      @map[finish] ||= []
      @map[finish] << start
    end
  end
end
  