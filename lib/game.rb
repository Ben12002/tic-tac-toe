require_relative 'symbols.rb'

class Game

  include Symbols

  attr_accessor :turn, :player_one
  
  def initialize
    @board = Board.new
    @game_over = false
    @turn = 1
    @player_one = Player.new(1)
    @player_two = Player.new(2)
  end

  def play

    puts "Please provide a move in the format x,y where the top left square is 0,0"
    
    while !game_over?
      curr_player = turn.odd? ? @player_one : @player_two
      process_input(curr_player)
      puts get_board.to_s
      self.turn += 1
    end
    puts get_winner
  end

  def process_input(player)
    valid_input = false
    valid_move = false
    
    while !valid_input && !valid_move
      print player.to_s + "'s turn:" 
      action = gets.chomp
      
      if action.match(/[0-2],[0-2]/) 
        validity = true
        move_arr = action.split(",")
        valid_move = move(move_arr[0], move_arr[1], player) # causing processinput move and print mocks to fail
       # valid_move = true
      end
    end
  end
    

  def game_over?
    get_board.consecutive_three?(SYMBOL_1) || get_board.consecutive_three?(SYMBOL_2) || get_board.board_full?

    # one = get_board.consecutive_three?(SYMBOL_1)
    # two = get_board.consecutive_three?(SYMBOL_2)
    # three = get_board.board_full?
    # one || two || three
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
    puts get_board.to_s
  end

  def to_s
    get_board.to_s
  end

  protected

  def get_board
    @board
  end

end