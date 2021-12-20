# common triplets any order pos or neg
def part_one(file)
  locator = Locator.new(file)
end

class Locator
  def initialize(file)
    parse_file(file)
    scanner_shared_beacons(@scanners[0],@scanners[1])
    binding.pry
  end

  def scanner_shared_beacons(s1,s2)
    d0 = distances_for(s1)
    d1 = distances_for(s2)
    intersectings = {}
    24.times do |o1|
      24.times do |o2|
        d0_o_keys = d0.keys.select{|key| key[2] == o1}
        d1_o_keys = d1.keys.select{|key| key[2] == o2}
        d0os = d0_o_keys.map{|k| d0[k] }
        d1os = d1_o_keys.map{|k| d1[k] }
        intersecting = (d0os & d1os)
        if intersecting.count >= 12
          intersectings[[o1,o2]] = intersecting unless intersectings.values.include?(intersecting)
        end
      end
    end

    s0_shared_8 = []
    s1_shared_8 = []
    intersectings[[8,8]].each do |diff|
      s0coor1,s0coor2,_ = d0.find{|k,v| v == diff }.first
      s1coor1,s1coor2,_ = d1.find{|k,v| v == diff }.first
      s0_shared_8 << s1[s0coor1][:coor]
      s0_shared_8 << s1[s0coor2][:coor]
      s1_shared_8 << s2[s1coor1][:coor]
      s1_shared_8 << s2[s1coor2][:coor]
    end

    s0_shared_8 = s0_shared_8.uniq
    s1_shared_8 = s1_shared_8.uniq

    s0_shared_0 = []
    s1_shared_0 = []
    intersectings[[0,0]].each do |diff|
      s0coor1,s0coor2,_ = d0.find{|k,v| v == diff }.first
      s1coor1,s1coor2,_ = d1.find{|k,v| v == diff }.first
      s0_shared_0 << s1[s0coor1][:coor]
      s0_shared_0 << s1[s0coor2][:coor]
      s1_shared_0 << s2[s1coor1][:coor]
      s1_shared_0 << s2[s1coor2][:coor]
    end

    s0_shared_0 = s0_shared_0.uniq
    s1_shared_0 = s1_shared_0.uniq
    #@scanners[1].find{|hsh| hsh[:coor] == [686,422,578]}[:orientations].find {|x,y,z| x - -618 <= 1000 && y - -824 <= 1000 && z - -621 <=1000}
    binding.pry
    
  end

  def distances_for(s_data)
    distances = {}
    24.times.each do |o|
      s_data.each_with_index do |f_coor, fi|
        s_data.each_with_index do |s_coor, si|
          next unless si > fi

          # val = 3.times.map {|n| (f_coor[:orientations][o][n].abs - s_coor[:orientations][o][n].abs).abs }
          val = 3.times.map {|n| (f_coor[:orientations][o][n] - s_coor[:orientations][o][n]).abs }
          distances[[fi,si,o]] = val
        end 
      end
    end
    distances
  end

  def parse_file(file)
    @scanners = {}
    current = nil
    orientations = {}
    File.readlines(file, chomp: true).each do |line|
      next if line == ""
      if line.include?('scanner')
        current = line.match(/scanner (\d+)/)[1].to_i
        @scanners[current] = []
      else
        coor = line.split(',').map(&:to_i)
        coor_data = {coor: coor, orientations: orientations_for_coor(coor) }
        @scanners[current] << coor_data
      end
    end
  end

  def orientations_for_coor(coor)
    [
      [coor[0],coor[1],coor[2]],
      [coor[0],coor[2],-coor[1]],
      [coor[0],-coor[1],-coor[2]],
      [coor[0],-coor[2],coor[1]],
      [-coor[0],-coor[1],coor[2]],
      [-coor[0],coor[2],coor[1]],
      [-coor[0],coor[1],-coor[2]],
      [-coor[0],-coor[2],-coor[1]],
      [coor[1],-coor[0],coor[2]],
      [coor[1],coor[2],coor[0]],
      [coor[1],coor[0],-coor[2]],
      [coor[1],-coor[2],-coor[0]],
      [-coor[1],coor[0],coor[2]],
      [-coor[1],coor[2],-coor[0]],
      [-coor[1],-coor[0],-coor[2]],
      [-coor[1],-coor[2],coor[0]],
      [coor[2],coor[0],coor[1]],
      [coor[2],coor[1],-coor[0]],
      [coor[2],-coor[0],-coor[1]],
      [coor[2],-coor[1],coor[0]],
      [-coor[2],coor[1],coor[0]],
      [-coor[2],coor[0],-coor[1]],
      [-coor[2],-coor[1],-coor[0]],
      [-coor[2],-coor[0],coor[1]]
    ]
  end
end

class Scanner
  def initialize(num)
    
  end
end
  