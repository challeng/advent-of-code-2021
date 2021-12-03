def part_one(file)
  bits, bits_by_index = bits_from_file(file)

  gamma = bits_by_index.map do |bit_group|
    bit_group.count { |bit| bit == 1} > bit_group.length / 2 ? 1 : 0
  end.join

  epsilon = gamma.each_char.map do |char|
    char == "1" ? "0" : "1"
  end.join

  gamma.to_i(2) * epsilon.to_i(2)
end

def part_two(file)
  binarys, bits_by_index = bits_from_file(file)
  oxygen(binarys) * co2(binarys)
end

def oxygen(binarys)
  filtered_binaries = binarys
  binarys.each_with_index do |binary, i|
    return filtered_binaries.first.to_i(2) if filtered_binaries.length == 1

    nums_for_index = filtered_binaries.map { |binary| binary[i] }
    ones_count = nums_for_index.count { |num| num == '1' }
    common_num = ones_count >= filtered_binaries.length - ones_count ? '1' : '0'
    filtered_binaries = filtered_binaries.filter { |binary| binary[i] == common_num }
  end
end

def co2(binarys)
  filtered_binaries = binarys
  binarys.each_with_index do |binary, i|
    return filtered_binaries.first.to_i(2) if filtered_binaries.length == 1

    nums_for_index = filtered_binaries.map { |binary| binary[i] }
    ones_count = nums_for_index.count { |num| num == '1' }
    zeroes_count = filtered_binaries.length - ones_count
    common_num = zeroes_count <= ones_count ? '0' : '1'
    filtered_binaries = filtered_binaries.filter { |binary| binary[i] == common_num }
  end
end

def bits_from_file(file)
  bits = []
  bits_by_index = []

  File.readlines(file).each do |line|
    binary = line.strip
    bits << binary 

    binary.each_char.with_index do |c, i|
      bits_by_index[i] ||= [] 
      bits_by_index[i] << c.to_i
    end
  end

  [bits, bits_by_index]
end
  