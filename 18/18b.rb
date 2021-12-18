def part_two(file)
  runner = Runner.new(file)
  runner.largest_mag
end

class Runner
  def initialize(file)
    @mags = []
    parse_file(file)
  end

  def parse_file(file)
    lines = File.readlines(file, chomp: true)#.map {|l| JSON.parse(l) }
    lines.permutation(2).each do |l1,l2|
      p1 = JSON.parse(l1)
      p2 = JSON.parse(l2)
      mather = MatherB.new(p1, p2)
      @mags << mather.mag
    end
  end

  def largest_mag
    @mags.max
  end
end

class MatherB
  def initialize(p1, p2)
    @nested_is = nil
    @large_num_is = nil
    @final = p1
    add!(p2)
    reduce!
  end

  def mag
    magnitude(@final)
  end

  def sum
    @final
  end

  def add!(pair)
    @final = [@final,pair]
  end

  def reduce!
    nested_el_index(@final)
    if should_explode?
      explode!
      reduce!
    elsif should_split?
      split!
      reduce!
    end
  end

  def explode!
    indexs = @nested_is
    val = @final.dig(*indexs)
    left = lnum(@final, indexs)
    if !left.nil?
      lval = left[:num] + val[0]
      set_el(left[:indexs], lval)
    end
    right =rnum(@final, indexs)
    if !right.nil?
      rval = right[:num] + val[1]
      set_el(right[:indexs], rval)
    end
    set_el(indexs, 0)
    @nested_is = nil
  end

  def set_el(is, val)
    last_index = is.last
    @final.dig(*is[0..-2])[last_index] = val
  end

  def lnum(arr, indexs)
    num = nil
    loop do
      i = indexs.rindex(1)
      break if i.nil?

      is = i == 0 ? [] : indexs[0..i-1]
      is = is + [0]
      el = arr.dig(*is)
      if el.is_a?(Array)
        val = rightmost_num(el)
        num = {num: val[:num], indexs: is + val[:indexs]}
        break
      else
        num = {num: el, indexs: is}
        break
      end
    end
    num
  end

  def rnum(arr, indexs)
    num = nil
    loop do
      i = indexs.rindex(0)
      break if i.nil?

      is = i == 0 ? [] : indexs[0..i-1]
      is = is + [1]
      el = arr.dig(*is)
      if el.is_a?(Array)
        val = leftmost_num(el)
        num = {num: val[:num], indexs: is + val[:indexs]}
        break
      else
        num = {num: el, indexs: is}
        break
      end
    end
    num
  end

  def leftmost_num(el, is=[])
    if el.is_a?(Integer)
      return {num: el, indexs: is}
    else
      leftmost_num(el[0],is + [0])
    end
  end

  def rightmost_num(el, is=[])
    if el.is_a?(Integer)
      return {num: el, indexs: is}
    else
      rightmost_num(el[1],is + [1])
    end
  end

  def should_explode?
    !!@nested_is
  end

  def nested_el_index(arr, indexs=[])
    if indexs.count == 4 && @nested_is.nil?
      @nested_is = indexs
      indexs
    else
      arr.each_with_index do |el, i|
        next unless el.is_a?(Array)
        nested_el_index(el, indexs+[i])
      end
      nil
    end
  end

  def split!
    val = @final.dig(*@large_num_is)
    new_el = [(val/2.0).round(half: :down), (val/2.0).round(half: :up)]
    set_el(@large_num_is, new_el)
    @large_num_is = nil
  end

  def should_split?
    large_num_index(@final)
    !!@large_num_is
  end

  def large_num_index(arr, indexs=[])
    arr.each_with_index do |el, i|
      if el.is_a?(Array) 
        large_num_index(el, indexs+[i])
      else
        @large_num_is = indexs+[i] if el >= 10 && @large_num_is.nil?
      end
    end
  end

  def magnitude(arr)
    left = arr[0].is_a?(Array) ? magnitude(arr[0]) : arr[0]
    right = arr[1].is_a?(Array) ? magnitude(arr[1]) : arr[1]

    3*left + 2*right
  end
end
  