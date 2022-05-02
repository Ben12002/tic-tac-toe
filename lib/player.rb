
class Player

  attr_reader :symbol, :num

  def initialize(symbol, num)
    @symbol = symbol
    @num = num
  end

  def to_s
    "Player #{@num}"
  end
end