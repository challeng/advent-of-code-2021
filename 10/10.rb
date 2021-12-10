def part_one(file)
  scorer = SyntaxScorer.new(file)
  scorer.score_errors
end

def part_two(file)
  scorer = SyntaxScorer.new(file)
  scorer.score_autocomplete
end

class SyntaxScorer
  attr_reader :lines

  def initialize(file)
    @lines = parse_file(file)
  end

  def score_errors
    errors = lines.map do |line| 
      parser = LineParser.new(line)
      parser.error if parser.error
    end.compact

    errors.sum { |l| error_score_map[l[:found]] }
  end

  def score_autocomplete
    line_scores = lines.map do |line|
      parser = LineParser.new(line)
      next if parser.error
      
      parser.missing.reduce(0) do |score, char|
        score *= 5
        score += autocomplete_score_map[char]
      end
    end.compact

    line_scores.sort[line_scores.length/2]
  end

  def error_score_map
    {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25137
    }
  end

  def autocomplete_score_map
    {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
    }
  end

  def parse_file(file)
    File.readlines(file, chomp: true).map { |l| l.chars }
  end
end

class LineParser
  attr_accessor :line, :chunks, :error, :missing

  def initialize(line)
    @line = line
    @chunks = []
    @error = nil
    @missing = []
    parse
  end

  def parse
    line.each do |char|
      if chunk_map.keys.include?(char)
        chunks << char
      else
        if chunk_map.key(char) == chunks.last
          chunks.pop
        else
          self.error = {expected: chunk_map[chunks.last], found: char}
          return
        end
      end
    end
    self.missing = chunks.reverse.map {|c| chunk_map[c]}
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
  