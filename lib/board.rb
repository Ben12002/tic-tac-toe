require_relative 'symbols.rb'

class Board

  include Symbols
  
  def initialize
    @arr = [[" "," "," "],
            [" "," "," "],
            [" "," "," "]]
    @game_over = false
  end

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
      if (@arr[x].filter{|cell| cell == symbol}.length == 3) || 
         ((@arr[0][x] == symbol) && 
         (@arr[1][x] == symbol) && 
         (@arr[2][x] == symbol))
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

  def add_to_board(i,j,symbol)

    if @arr[i.to_i][j.to_i] == " "
      @arr[i.to_i][j.to_i] = symbol
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



