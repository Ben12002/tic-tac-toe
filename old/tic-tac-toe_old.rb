module Symbols
  SYMBOL_1 = "X"
  SYMBOL_2 = "O"
end

#===============================================================================
class Game

  include Symbols
  
  def initialize
    @board = Board.new
    @game_over = false
  end

  def is_game_over?
    get_board.is_game_over?
  end

  def get_winner
    if get_board.consecutive_three?(SYMBOL_1)
      "player 1 wins!"
    elsif get_board.consecutive_three?(SYMBOL_2)
      "player 2 wins!"
    else
      "Draw!"
    end
  end

  def move(i,j, player)
    get_board.add_to_board(i,j,player.symbol)
  end

  def display_board
    puts @board.to_s
  end

  def to_s
    @board.to_s
  end

  protected

  def get_board
    @board
  end

end
#===============================================================================
class Board

  include Symbols
  
  def initialize
    @arr = [[" "," "," "],
            [" "," "," "],
            [" "," "," "]]
    @game_over = false
  end

  # TODO
  def board_full?
    # use reduce to count number of " ". full if no. of " " == 0
    empty_count = @arr.reduce(0) do |count, curr|
      empty_per_col = curr.reduce(0) do |count2, curr2|
        count2 += 1 if curr2 == " "
        count2
      end
      count += empty_per_col
      count
    end

    empty_count == 0
  end

  def consecutive_three?(symbol)
    flag = false

    for x in 0..2
      if (@arr[x].filter{|cell| cell == symbol}.length == 3) || ((@arr[0][x] == symbol) && (@arr[1][x] == symbol) && (@arr[2][x] == symbol))
        flag = true
      end
    end

    if (@arr[0][0] == symbol) && (@arr[1][1] == symbol) && (@arr[2][2] == symbol)
      flag = true
    end

    if (@arr[2][0] == symbol) && (@arr[1][1] == symbol) && (@arr[0][2] == symbol)
      flag = true
    end
    flag
  end

  # TODO
  # check if:
  # - any 3 symbols in a row
  # - no 3 symbols in a row AND board is full (draw)
  def is_game_over?
    consecutive_three?(SYMBOL_1) || consecutive_three?(SYMBOL_2) || board_full?
  end


  # TODO
  def add_to_board(i,j,symbol)
    i = i.to_i
    j = j.to_i
    if @arr[i][j] == " "
      @arr[i][j] = symbol
      return true
    else
      return false
    end
  end

  def to_s
   "       #{@arr[0][0]} |  #{@arr[1][0]} |  #{@arr[2][0]}\n 
   ----------------------\n  
       #{@arr[0][1]} | #{@arr[1][1]} | #{@arr[2][1]}\n
   ----------------------\n 
       #{@arr[0][2]} | #{@arr[1][2]} | #{@arr[2][2]}"
  end

end

#===============================================================================
class Player

  include Symbols
  attr_reader :symbol

  def initialize(num)
    if num == 1
      @num = 1
      @symbol = SYMBOL_1
    else
      @num = 2
      @symbol = SYMBOL_2
    end
  end

  def to_s
    "Player #{@num}"
  end
end

#===============================================================================


def process_input(game, player, turn)
  valid_input = false
  valid_move = false
 
  while !valid_input && !valid_move
    print player.to_s + "'s turn:" 
    action = gets.chomp
    
    if action.match(/[0-2],[0-2]/) 
      validity = true
      move_arr = action.split(",")
      valid_move = game.move(move_arr[0], move_arr[1], player)
    end
  end
end


# Program loop
on = true
while on
  # Initialize objects
  puts "Please provide a move in the format x,y where the top left square is 0,0"
  game = Game.new
  player_one = Player.new(1)
  player_two = Player.new(2)
  turn = 1

  # Game loop
  while !game.is_game_over?
    curr_player = turn.odd? ? player_one : player_two
    process_input(game, curr_player, turn)
    puts game.to_s
    turn += 1
  end
  puts game.get_winner

  # After game ends, give option to play again or end program
  answer = ""
  while answer != "y" && answer != "n"
    puts "would you like to play again? (y/n)"
    answer = gets.chomp

    if answer == "n"
      puts "Shutting down......."
      on = false
    elsif answer != "y"
      puts "invalid answer"
    else
      puts "Another game!"
    end
  end
end


