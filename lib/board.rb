
class Board
  
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

  def valid_move?(i,j)
    # Order is crucial. Switching the order will lead to error if user types in numbers that exceed the bounds of array. 
    ((i.to_i < 3) && (j.to_i < 3)) && (@arr[i.to_i][j.to_i] == " ")
  end

  def add_to_board(i,j,symbol)
      @arr[i.to_i][j.to_i] = symbol
  end

  def to_s
    <<-HEREDOC
       #{@arr[0][0]} | #{@arr[1][0]} | #{@arr[2][0]}
      ---+---+---
       #{@arr[0][1]} | #{@arr[1][1]} | #{@arr[2][1]}
      ---+---+---
       #{@arr[0][2]} | #{@arr[1][2]} | #{@arr[2][2]}
    HEREDOC
  end

end



