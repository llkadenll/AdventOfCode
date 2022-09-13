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
  return column.sort.reverse.join.scan(/[0-1]/).tally.max_by{|k,v| v}[0]
end

def get_least_common_bit(column)
  return column.sort.join.scan(/[0-1]/).tally.min_by{|k,v| v}[0]
end

def get_oxygen_generator_rating(report)
  most_common_bits = ""
  ogr = report.clone
  for i in 0...report[0].length
    most_common_bits += get_most_common_bit(ogr.map { |row| row[i] })
    ogr.reject! { |row| !row.start_with?(most_common_bits) }
  end

  return ogr.join
end

def get_co2_scrubber_rating(report)
  least_common_bits = ""
  co2sr = report.clone
  for i in 0...report[0].length
    least_common_bits += get_least_common_bit(co2sr.map { |row| row[i] })
    co2sr.reject! { |row| !row.start_with?(least_common_bits) }
  end

  return co2sr.join
end

def get_life_support_rating(ogr, co2sr)
  return ogr.to_i(2) * co2sr.to_i(2)
end

report = read_file("day3.txt")
oxygen_generator_rating = get_oxygen_generator_rating(report)
co2_scrubber_rating = get_co2_scrubber_rating(report)
life_support_rating = get_life_support_rating(oxygen_generator_rating, co2_scrubber_rating)
puts life_support_rating
