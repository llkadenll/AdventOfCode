def read_data(file_name)
  file = File.open(file_name, "r")

  numbers = file.readline.split(',').map { |number| number.to_i }
  file.readline
  file_data = file.read.split("\n\n")
  boards = file_data.map { |board| board.split("\n").map! { |row| row.split(" ").map! { |number| number.to_i } } }

  file.close
  return numbers, boards
end

def check_bingo(array)
  return array == Array.new(5, true)
end

def mark_number(number, boards, checked_boards, winners)
  boards.each_with_index do |board, board_index|
    unless winners.include?(board_index)
      board.each_with_index do |row, row_index|
        i = row.index(number)
        unless i.nil?
          checked_boards[board_index][row_index][i] = true
        end
      end
    end
  end

  return nil
end

def check_board(checked_board, winners)
  return checked_board.any? { |row| check_bingo(row) == true } || checked_board.transpose.any? { |row| check_bingo(row) == true }
end

def find_bingo(numbers, boards, checked_boards)
  winners = Array.new
  last_winner_number = nil

  numbers.each do |number|
    mark_number(number, boards, checked_boards, winners)

    boards.each_with_index do |board, board_index|
      winner = !winners.include?(board_index) && check_board(checked_boards[board_index], winners) ? board_index : nil

      unless winner.nil?
        winners.push(winner)
        last_winner_number = number
      end
    end
  end

  return winners.last, last_winner_number
end

def count_score(board, checked_board, number)
  score = 0
  board.each_with_index do |row, row_index|
    row.each_with_index do |number, i|
      if checked_board[row_index][i] == false
        score += number
      end
    end
  end

  score *= number
  return score
end

numbers, boards = read_data("day4.txt")

checked_boards = Array.new(boards.length) { Array.new(5) { Array.new(5, false) } }
winner, last_number = find_bingo(numbers, boards, checked_boards)
score = count_score(boards[winner], checked_boards[winner], last_number)
puts score
