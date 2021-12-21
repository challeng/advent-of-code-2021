def part_one(file)
  gamer = GamerA.new(file)
  gamer.run
end

class GamerA
  def initialize(file)
    @die = Die.new
    @p1_score = 0
    @p2_score = 0
    parse_file(file)
  end

  def run
    winner = nil
    loop do
      p1_turn
      winner = 1 and break if @p1_score >= 1000
      p2_turn
      winner = 2 and break if @p2_score >= 1000
    end

    score(winner)
  end

  def score(winner)
    loser_score = winner == 1 ? @p2_score : @p1_score
    loser_score * @die.roll_count
  end

  def p1_turn
    @p1_pos = turn(@p1_pos)
    @p1_score += @p1_pos
  end
  def p2_turn
    @p2_pos = turn(@p2_pos)
    @p2_score += @p2_pos
  end

  def parse_file(file)
    lines = File.readlines(file, chomp: true)
    @p1_pos = lines[0].split(': ')[1].to_i
    @p2_pos = lines[1].split(': ')[1].to_i
  end

  def turn(pos)
    r1 = @die.roll
    r2 = @die.roll
    r3 = @die.roll

    pos = pos + r1 + r2 + r3
    while pos > 10 do 
      pos -= 10
    end
    pos
  end
end
  
class Die
  attr_reader :roll_count

  def initialize
    @roll = 1
    @roll_count = 0
  end

  def roll
    @roll_count += 1
    @roll.tap { increment }
  end

  def increment
    @roll += 1
    @roll = 1 if @roll == 101
  end
end