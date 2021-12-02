module DayOne
  def part_one(file)
    last_measurement = nil
    increases = 0

    File.foreach(file) do |measurement| 
      measurement = measurement.strip.to_i
      if last_measurement && measurement > last_measurement
        increases += 1
      end
      
      last_measurement = measurement
    end

    increases
  end

  def part_two(file)
    last_window_sum = nil
    current_window = []
    increases = 0

    File.foreach(file) do |measurement| 
      measurement = measurement.strip.to_i
      current_window << measurement

      next if current_window.length < 3
      current_window.shift if current_window.length > 3

      if last_window_sum && current_window.sum > last_window_sum
        increases += 1
      end

      last_window_sum = current_window.sum
    end

    increases 
  end

  def part_one_cons(file)
    File.readlines(file)
        .map { |el| el.strip.to_i }
        .each_cons(2)
        .map { |pair| pair[1] > pair[0] ? 1 : 0 }
        .sum
  end

  def part_two_cons(file)
    File.readlines(file)
        .map { |el| el.strip.to_i }
        .each_cons(3)
        .each_cons(2)
        .map { |windows| windows[1].sum > windows[0].sum ? 1 : 0 }
        .sum
  end
end
