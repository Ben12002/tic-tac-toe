
class Game

  attr_reader :turn, :board, :player_one, :player_two

  def initialize
    @board = Board.new
    @game_over = false
    @turn = 1
  end

  def play
    introduction
    turns
    puts get_winner
  end

  def introduction
    puts "Enter a character to use for player 1: "
    @player_one = create_character(1)

    puts "Enter a character to use for player 2. Cannot be #{@player_one.symbol} : "
    @player_two = create_character(2)

    puts "Please provide a move in the format x,y where the top left square is 0,0"
  end

  def create_character(num)
    symbol = get_symbol_input
    if num == 2
      if (symbol == @player_one.symbol)
        puts "please choose a different character: "
        create_character(num)
      else
        @player_two = Player.new(symbol, 2)
      end
    else
      @player_one = Player.new(symbol, 1)
    end
  end



  # Before refactor. while !<condition> changed to until <condition>
  # -------------------------------
  # def turns
  #   while !game_over?
  #     current_player = @turn.odd? ? @player_one : @player_two
  #     turn(current_player)
  #     display_board
  #     @turn += 1
  #   end
  # end

  def turns
    until game_over?
      current_player = @turn.odd? ? @player_one : @player_two
      turn(current_player)
      display_board
      @turn += 1
    end
  end




  def turn(player)
    print player.to_s + "'s turn: "
    player_move = get_move_input
    move(player_move[0],player_move[1], player)
  end


  # Before refactor. while true changed to loop do, using return instead of break (and implicit return)
  #----------------------------------
  # def get_move_input
  #   while true
  #     action = gets.chomp
  #     if valid_input?(action)
  #       player_move = action.split(",")
  #       if @board.valid_move?(player_move[0], player_move[1])
  #         break
  #       end
  #     end
  #     print "Invalid move. Please try again: "
  #   end
  #   player_move
  # end
  #----------------------------------

  def get_move_input
    loop do
      player_move = gets.chomp.split(",")
      return player_move if @board.valid_move?(player_move[0], player_move[1])
      print "Invalid move. Please try again: "
    end
  end




  # Before refactor. while true changed to loop do, using return instead of break (and implicit return)
  #----------------------------------
  # def get_symbol_input

  #   while true
  #     answer = gets.chomp
  #     if answer.length == 1
  #       break
  #     end
  #     puts "Please enter only one character."
  #   end
  #   answer
  # end
  #----------------------------------

  def get_symbol_input
    loop do
      answer = gets.chomp
      return answer if answer.length == 1
      puts "Please enter only one character."
    end
  end


  # Before refactor. functionality moved to @board.valid_move? since this method requires 
  # implementation details of the Board class.
  #----------------------------------
  # def valid_input?(input)
  #   input.match(/[0-2],[0-2]/)
  # end
  #----------------------------------


  def game_over?
    player_one_wins = @board.consecutive_three?(@player_one.symbol)
    player_two_wins = @board.consecutive_three?(@player_two.symbol)
    draw = @board.board_full?

    player_one_wins || player_two_wins || draw
  end

  def get_winner
    if @board.consecutive_three?(@player_one.symbol)
      "player 1 wins!"
    elsif @board.consecutive_three?(@player_two.symbol)
      "player 2 wins!"
    else
      "Draw!"
    end
  end

  def move(i,j, player)
    @board.add_to_board(i,j,player.symbol)
  end

  def display_board
    puts @board
  end

end