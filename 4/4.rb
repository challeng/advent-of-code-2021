def part_one(file)
  player = Player.new(file)
  player.play_for_winner
end

def part_two(file)
  player = Player.new(file)
  player.play_for_loser
end
  
class Player
  attr_reader :inputs, :boards

  def initialize(file)
    parse_file(file) 
  end

  def play_for_winner
    inputs.each do |input|
      boards.each do |board|
        board.play_num(input)
        return result(board, input) if board.winner?
      end
    end
  end

  def play_for_loser
    win_count = 0
    inputs.each do |input|
      boards.each do |board|
        next if board.winner?

        board.play_num(input)
        win_count += 1 if board.winner?
        
        return result(board, input) if win_count == boards.length
      end
    end
  end

  def result(board, input)
    board.unmarked_sum * input.to_i
  end

  def parse_file(file)
    lines = File.readlines(file).map(&:chomp)
    input_row, *board_lines = lines
    @inputs = input_row.split(',')

    @boards = board_lines.each_slice(6).map do |slice|
      Board.new(slice[1..-1])
    end
  end
end

class Board
  attr_reader :rows

  def initialize(rows)
    @win = false
    @rows = rows.map do |row| 
      row.split(' ').map { |num| {num: num, hit: false} }
    end
  end

  def unmarked_sum
    rows.flatten
        .filter { |el| !el[:hit] }
        .sum { |el| el[:num].to_i }  
  end

  def play_num(num)
    rows.each do |row|
      row.each do |el|
        el[:hit] = true if el[:num] == num
      end
    end
  end

  def winner?
    winning_row? || winning_col?
  end

  def winning_row?
    rows.any? { |row| row.all? {|el| el[:hit] }}
  end

  def winning_col?
    rows.transpose.any? { |row| row.all? {|el| el[:hit] }}
  end
end