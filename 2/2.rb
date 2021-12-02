module DayTwo
	def part_one(file)
		horizontal = 0
		depth = 0

		commands(file).each do |command, amt|
			case command
			when 'forward'
				horizontal += amt
			when 'down'
				depth += amt
			when 'up'
				depth -= amt
			end
		end

		horizontal * depth
	end

	def part_two(file)
		horizontal = 0
		depth = 0
		aim = 0

		commands(file).each do |command, amt|
			case command
			when 'forward'
				horizontal += amt
				depth += amt * aim
			when 'down'
				aim += amt
			when 'up'
				aim -= amt
			end
		end

		horizontal * depth
	end

	def commands(file)
		File.readlines(file).map do |line|
			line.strip.split(' ').tap { |cmd| cmd[1] = cmd[1].to_i }
		end
	end
end
