def part_one(str, file: false)
  converter = Converter.new(str, file: file)
  converter.version_sum
end

def part_two(str, file: false)
  converter = Converter.new(str, file: file)
  converter.value
end

class Converter
  def initialize(str, file:)
    if file
      @hex = parse_file(str)
    else
      @hex = str.chars
    end
  end

  def value
    binary = @hex.map { |char| binary_map[char.to_s] }.join
    packet = Packet.new(binary)
    packet.value
  end

  def version_sum
    binary = @hex.map { |char| binary_map[char.to_s] }.join
    packet = Packet.new(binary)
    packet.version_sum
  end

  def parse_file(file)
    File.readlines(file, chomp: true).first.chars
  end

  def binary_map
    {
      '0' => '0000',
      '1' => '0001',
      '2' => '0010',
      '3' => '0011',
      '4' => '0100',
      '5' => '0101',
      '6' => '0110',
      '7' => '0111',
      '8' => '1000',
      '9' => '1001',
      'A' => '1010',
      'B' => '1011',
      'C' => '1100',
      'D' => '1101',
      'E' => '1110',
      'F' => '1111'
    }
  end
end

class Packet
  attr_reader :binary, :version, :type_id, :literal, :packets, :length_type_id

  def initialize(binary)
    @binary = binary
    @packets = []
    @version = binary[0..2].to_i(2)  
    @type_id = binary[3..5].to_i(2)
    @length_type_id = @binary[6]
    if literal?
      @literal_length = 6
      @literal = make_literal
    else
      make_packets 
    end
  end

  def make_packets
    if length_type_id == '0'
      total_length_packets
    else
      number_sub_packets
    end
  end

  def number_sub_packets
    num_sub_packets = @binary[7..17].to_i(2)
    next_packets = @binary[18..-1]
    while num_sub_packets != 0
      p_length = Packet.new(next_packets).length
      packet = Packet.new(next_packets[0..(p_length-1)])
      @packets << packet

      num_sub_packets -= 1
      next_packets = next_packets[p_length..-1]
    end
  end

  def total_length_packets
    sub_packet_length = @binary[7..21].to_i(2)
    next_packets = @binary[22..(22+sub_packet_length-1)]
    while sub_packet_length != 0 && next_packets.length != 0
      p_length = Packet.new(next_packets).length
      packet = Packet.new(next_packets[0..(p_length-1)])
      @packets << packet

      next_packets = next_packets[p_length..-1]
    end
  end

  def length
    if literal?
      @literal_length
    else
      length_extra = length_type_id == '0' ? 15 : 11
      @packets.sum { |packet| packet.length } + 7 + length_extra
    end
  end

  def make_literal
    str = @binary[6..-1]
    num = ''
    str.chars.each_slice(5).each do |slice|
      @literal_length += 5
      num += slice[1..-1].join('')
      break if slice[0] == '0'
    end

    num
  end

  def value
    case type_id
    when 0
      packets.sum {|p| p.value }
    when 1
      packets.inject(1) {|acc, p| acc * p.value}
    when 2
      packets.map{|p| p.value}.min
    when 3
      packets.map{|p| p.value}.max
    when 4
      @literal.to_i(2)
    when 5
      packets[0].value > packets[1].value ? 1 : 0
    when 6
      packets[0].value < packets[1].value ? 1 : 0
    when 7
      packets[0].value == packets[1].value ? 1 : 0
    end
  end

  def version_sum
    return @version if literal?
    packets.sum {|packet| packet.version_sum} + @version
  end

  def literal?
    type_id == 4
  end
end
