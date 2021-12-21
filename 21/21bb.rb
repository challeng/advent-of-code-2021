def part_twos(file)
  Runner.new(file).run
end

class Runner
  attr_accessor :w1, :w2, :p1_scores, :p2_scores
  def initialize(file)
    parse_file(file)
    @w1 = 0
    @w2 = 0

    #p1p,p1s,p2p,p2s
    @final = Hash.new(0)
    @final[[@p1_pos,0,@p2_pos,0]] = 1
  end

  def run
    loop do
      p1_turn
      determine_winners 
      p2_turn
      determine_winners 
      break if over?
    end
    @w1 > @w2 ? @w1 : @w2
  end

  def over?
    @final.empty?
  end

  def determine_winners
    new_final = @final.dup
    new_final.each do |(p1p,p1s,p2p,p2s), count|
      if p1s >= 21
        @w1 += count
        @final.delete([p1p,p1s,p2p,p2s])
      elsif p2s >= 21
        @w2 += count
        @final.delete([p1p,p1s,p2p,p2s])
      end
    end
  end

  def p1_turn
    new_final = Hash.new(0)
    @final.each do |(p1p,p1s,p2p,p2s), count|
      moves.each do |spaces, move_count|
        new_pos = p1p + spaces
        new_pos -= 10 if new_pos > 10
        new_score = p1s + new_pos
        new_final[[new_pos,new_score,p2p,p2s]] += move_count * count
      end
    end
    @final = new_final
  end
  
  def p2_turn
    new_final = Hash.new(0)
    @final.each do |(p1p,p1s,p2p,p2s), count|
      moves.each do |spaces, move_count|
        new_pos = p2p + spaces
        new_pos -= 10 if new_pos > 10
        new_score = p2s + new_pos
        new_final[[p1p,p1s,new_pos,new_score]] += move_count * count
      end
    end
    @final = new_final
  end

  def moves
    # spaces, count
    [
      [3,1],
      [4,3],
      [5,6],
      [6,7],
      [7,6],
      [8,3],
      [9,1]
    ]
  end

  def parse_file(file)
    lines = File.readlines(file, chomp: true)
    @p1_pos = lines[0].split(': ')[1].to_i
    @p2_pos = lines[1].split(': ')[1].to_i
  end
end



