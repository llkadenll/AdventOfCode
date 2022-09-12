def read_file(file_name)
  plan = Array.new()
  file = File.open(file_name)
  file_data = file.readlines.map(&:chomp)

  for i in 0...file_data.length do
    plan.push(file_data[i])
  end

  plan
end

def calculate_position(plan)
  horizontal = 0
  depth = 0

  plan.each do |arr|
    move = arr.split()
    case move[0]
    when "up"
      depth -= move[1].to_i
    when "down"
      depth += move[1].to_i
    when "forward"
      horizontal += move[1].to_i
    end
  end

  total = horizontal * depth
  total
end

plan = read_file("day2.txt")
puts calculate_position(plan)
