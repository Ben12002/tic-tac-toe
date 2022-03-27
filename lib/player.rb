require_relative 'symbols.rb'

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