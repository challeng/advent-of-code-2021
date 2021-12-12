def part_one(file)
  path_finder = PathFinder1.new(file)
  path_finder.find_paths
end

def part_two(file)
  path_finder = PathFinder2.new(file)
  path_finder.find_paths
end

class PathFinder2
  attr_reader :map, :paths

  def initialize(file)
    parse_file(file)
    @paths = []
  end

  def find_paths
    small_caves = map.values.flatten.select do |v|
      v.downcase == v && v != 'start' && v != 'end'}.uniq
    end
    small_caves.each { |cave| find('start', ['start'], cave) }
    paths.count
  end

  def find(node, path)
    if node == 'end'
      paths << path
      return
    end

    map[node].each do |dest|
      next if cannot_visit?(dest, path)
      find(dest, path + [dest])
    end
  end

  def cannot_visit?(dest, path)
    dest == 'start' ||
      path.last == 'end' ||
      (small_cave?(dest) && path.count{|node| node == dest} == 2)
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

class PathFinder1
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
      paths << path
      return
    end

    map[node].each do |dest|
      next if cannot_visit?(dest, path)
      find(dest, path + [dest])
    end
  end

  def cannot_visit?(dest, path)
    (path.include?(dest) && small_cave?(dest)) || path.last == 'end'
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
  