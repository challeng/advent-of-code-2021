def part_one(file)
  path_finder = PathFinder.new(file)
  path_finder.find_paths_one
end

def part_two(file)
  path_finder = PathFinder.new(file)
  path_finder.find_paths_two
end

class PathFinder
  attr_reader :map, :paths

  def initialize(file)
    parse_file(file)
    @paths = []
  end

  def find_paths_one
    find('start', ['start'])  
    paths.count
  end

  def find_paths_two
    small_caves = map.values.flatten.select do |v|
      v.downcase == v && v != 'start' && v != 'end'
    end.uniq
    small_caves.each { |cave| find('start', ['start'], cave) }
    paths.uniq.count
  end

  def find(node, path, cave=nil)
    paths << path and return if node == 'end'

    map[node].each do |dest|
      next if cannot_visit?(dest, path, cave)
      find(dest, path + [dest], cave)
    end
  end

  def cannot_visit?(dest, path, cave)
    dest == 'start' ||
      path.last == 'end' ||
      (dest != cave && small_cave?(dest) && path.include?(dest)) ||
      (dest == cave && small_cave?(dest) && path.count{|node| node == dest} == 2)
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
  