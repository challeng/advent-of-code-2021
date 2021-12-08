def part_one(file)
  display_decoder = DisplayDecoder.new(file)
  display_decoder.uniq_length_count
end

def part_two(file)
  display_decoder = DisplayDecoder.new(file)
  display_decoder.output_sum
end

Display = Struct.new(:signals, :output)

class DisplayDecoder
  attr_reader :displays, :section_to_segment, :num_to_segments

  def initialize(file)
    @displays =  parse_file(file)
  end

  def uniq_length_count
    displays.sum { |display| Decoder.new(display).count_uniq_segments_from_output }
  end

  def output_sum
    displays.map do |display|
      decoder = Decoder.new(display)
      decoder.decode
    end.sum
  end

  def parse_file(file)
    File.readlines(file).map do |line|
      Display.new(*line.chomp.split('|').map {|section| section.split(' ').map{|num| num.chars.sort}})
    end
  end
end

class Decoder
  attr_reader :display, :num_to_segments

  def initialize(display)
    @display = display
    @num_to_segments = {}
  end

  def decode
    segments = display.signals + display.output
    decode_by_uniq_length(segments)
    num_to_segments[9] = segments_by_length(segments, 6).find { |seg| (seg - num_to_segments[4] - num_to_segments[7]).length == 1 }
    num_to_segments[0] = segments_by_length(segments, 6).find { |seg| seg != num_to_segments[9] && (num_to_segments[7] - seg).empty? }
    num_to_segments[6] = segments_by_length(segments, 6).find { |seg| seg != num_to_segments[9] && seg != num_to_segments[0] }
    num_to_segments[2] = segments_by_length(segments, 5).find { |seg| !(seg - num_to_segments[9]).empty? }
    num_to_segments[3] = segments_by_length(segments, 5).find { |seg| seg != num_to_segments[2] && (num_to_segments[7] - seg).empty? }
    num_to_segments[5] = segments_by_length(segments, 5).find { |seg| seg != num_to_segments[2] && seg != num_to_segments[3] }

    display.output.map do |num|
      num_to_segments.key(num.sort)
    end.join.to_i
  end

  def decode_by_uniq_length(segments)
    segments.each do |segment|
      real_num = length_to_num[segment.length]
      num_to_segments[real_num] = segment if real_num
    end
  end

  def segments_by_length(segments, length)
    segments.select { |seg| seg.length == length }
  end

  def count_uniq_segments_from_output
    display.output.count { |num| length_to_num[num.length] }
  end

  def uniq_segments
    [segment_map[1], segment_map[4], segment_map[7], segment_map[8]]  
  end

  def length_to_num
    {
      2 => 1,
      4 => 4,
      3 => 7,
      7 => 8
    }
  end
end
  