def part_one(file)
  scorer = SyntaxScorer.new(file)
  scorer.score_bad_lines
end

def part_two(file)
  runner = Runner.new(file)
end

class SyntaxScorer
  attr_reader :lines

  def initialize(file)
    @lines = parse_file(file)
  end

  def score_bad_lines
    bad_lines = lines.map do |line| 
      parsed_line = LineParser.new(line).parse
      parsed_line if parsed_line[:expected]
    end.compact

    bad_lines.sum { |l| score_map[l[:found]] }
  end

  def score_map
    {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25137
    }
  end

  def parse_file(file)
    File.readlines(file, chomp: true).map { |l| l.chars }
  end
end

class LineParser
  attr_reader :line, :chunks, :error

  def initialize(line)
    @line = line
    @chunks = []
    @error = nil
  end

  def parse
    line.each do |char|
      if chunk_map.keys.include?(char)
        chunks << char
      else
        if chunk_map.key(char) == chunks.last
          chunks.pop
        else
          return {expected: chunk_map[chunks.last], found: char}
        end
      end
    end

    {}
  end

  def chunk_map
    {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
    }
  end
end
  