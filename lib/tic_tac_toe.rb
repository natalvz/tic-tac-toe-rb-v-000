WIN_COMBINATIONS = 
[
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player_token)
  board[index] = player_token
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if index.between?(0,8)
    if position_taken?(board,index) == false
      return true
    else
      return false
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    return move(board, index, current_player(board))
    display_board(board)
  else turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.count do |count|
    if count != " "
      counter+=1
      end
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
   "X"
  else
    "O"
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? { |token|
      board[token] == "X" }
      return "X"
    elsif win_combination.all? { |token|
      board[token] == "O" }
      return "O"
    end
  end
    if won?(board) == false
      return nil
      end
end

def won?(board)

  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] && board[win_combination[0]] == board[win_combination[2]] && position_taken?(board, win_combination[0])
  end
end

def full?(board)
 board.all? {|cell| cell == "X" || cell == "O"}
  
end 

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def play(board)
  while !over?(board)
  turn(board)
  end
if won?(board)
  if winner(board) == "X"
    return puts "Congratulations X!"
  else 
    return puts "Congratulations O!"
  end
else draw?(board)
  puts "Cat's Game!"
end
end