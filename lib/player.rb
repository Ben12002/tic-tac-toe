require_relative 'symbols.rb'

class Player

  include Symbols
  attr_reader :symbol

  def initialize(num)
    if num == 1
      @num = 1
      @symbol = "X"
    else
      @num = 2
      @symbol = "O"
    end
  end

  def to_s
    "Player #{@num}"
  end
end