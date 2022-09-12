def read_file(file_name)
  report = Array.new()
  file = File.open(file_name)
  file_data = file.readlines.map(&:chomp)
  for i in 0...file_data.length do
    report.push(file_data[i].to_i)
  end
  report
end

def count_increasing(report)
  increasing = 0
  for i in 1...report.length-2 do
    a = report[i-1] + report[i] + report [i+1]
    b = report[i] + report[i+1] + report [i+2]

    print a, " ", b, "\n"

    if b > a
      increasing += 1
    end
  end
  increasing
end

report = read_file("day1.txt")
puts count_increasing(report)
