def read_file(file_name)
  report = Array.new()
  file = File.open(file_name)
  file_data = file.readlines.map(&:chomp)

  for i in 0...file_data.length do
    report.push(file_data[i])
  end

  report
end

def get_most_common_bit(column)
  return column.join.scan(/[0-1]/).tally.max_by{|k,v| v}[0]
end

def get_gamma_rate(report)
  gamma = String.new
  for i in 0...report[0].length
    gamma += get_most_common_bit(report.map { |row| row[i] })
  end
  
  return gamma
end

def get_epsilon_rate(gamma)
  return gamma.split('').map { |b| b == "0" ? "1" : "0" }.join
end

def get_power_consumption(gamma, epsilon)
  return gamma.to_i(2) * epsilon.to_i(2)
end

report = read_file("day3.txt")
gamma = get_gamma_rate(report)
epsilon = get_epsilon_rate(gamma)
power_consumption = get_power_consumption(gamma, epsilon)
puts power_consumption
