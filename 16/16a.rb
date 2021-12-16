def part_one(str, file: false)
  converter = ConverterA.new(str, file: file)
  converter.convert
end

class ConverterA
  def initialize(str, file:)
    if file
      @hex = parse_file(str)
    else
      @hex = str.chars
    end
  end

  def convert
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
    @type = type(type_id)
    @length_type_id = @binary[6]
    if @type == :operator
      make_packets 
    else
      @literal_length = 6
      @literal = make_literal
    end
  end

  def make_packets
    # length_type_id = @binary[6]
    # binding.pry if @version == 1
    if length_type_id == '0'
      #then the next 15 bits are a number that represents the total length in bits
      # of the sub-packets contained by this packet.
      sub_packet_length = @binary[7..21].to_i(2)
      next_packets = @binary[22..(22+sub_packet_length-1)]
      # binding.pry if @version == 5
      # binding.pry if next_packets == nil
      while sub_packet_length != 0 && next_packets.length != 0
        p_length = Packet.new(next_packets).length
        packet = Packet.new(next_packets[0..(p_length-1)])
        @packets << packet

        next_packets = next_packets[p_length..-1]
      end
    else
      # next 11 bits are a number that represents the number of sub-packets
      #immediately contained by this packet.
      # binding.pry
      num_sub_packets = @binary[7..17].to_i(2)
      next_packets = @binary[18..-1]
      while sub_packet_length != 0 && num_sub_packets != 0
        p_length = Packet.new(next_packets).length
        packet = Packet.new(next_packets[0..(p_length-1)])
        @packets << packet

        num_sub_packets -= 1
        next_packets = next_packets[p_length..-1]
      end
    end
  end

  def length
    if @type == :literal
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

  def version_sum
    return @version if @type == :literal
    packets.sum {|packet| packet.version_sum} + @version
  end

  def type(type_id)
    return :literal if type_id == 4
    :operator
  end
end

#100010100000000001001010100000000001101010000000000000101111010001111000
#vers,typ,tid,count/length,    str
# 4,  2,  1    1
# 100,010,1,00000000001,001010100000000001101010000000000000101111010001111000
#  1 , 2 ,1       1
# 001,010,1,00000000001,101010000000000000101111010001111000
#  5, 2  ,0,    11
# 101,010,0,000000000001011,11010001111000
  