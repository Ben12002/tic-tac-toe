require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Board do

  subject(:board){ described_class.new }

  describe '#board_full?' do

    context 'full' do
      before do
        board.instance_variable_set(:@arr, [["X","O","X"],
                                            ["O","X","O"],
                                            ["O","X","O"]])
      end

      it 'returns true' do
        expect(board.board_full?).to be true
      end
    end

    context 'not full' do
      before do
        board.instance_variable_set(:@arr, [["X","O","X"],
                                            [" ","X","O"],
                                            ["O","X","O"]])
      end

      it 'returns false' do
        expect(board.board_full?).to be false
      end
    end
  end

  describe '#consecutive_three?' do
    
    context 'no consecutive' do
      before do
        board.instance_variable_set(:@arr, [["X","O","X"],
                                            ["O","X","O"],
                                            ["O","X","O"]])
      end

      it 'returns false' do
        expect(board.consecutive_three?("X")).to be false
        expect(board.consecutive_three?("O")).to be false
      end
    end

    context 'diagonal' do
      before do
        board.instance_variable_set(:@arr, [["X","O","X"],
                                            ["O","X","O"],
                                            ["O","X","X"]])
      end

      it 'returns true' do
        expect(board.consecutive_three?("X")).to be true
        expect(board.consecutive_three?("O")).to be false
      end
    end

    context 'row' do
      before do
        board.instance_variable_set(:@arr, [["X","O","X"],
                                            ["O","O","O"],
                                            ["O","X","O"]])
      end

      it 'returns true' do
        expect(board.consecutive_three?("X")).to be false
        expect(board.consecutive_three?("O")).to be true
      end
    end

    context 'column' do
      before do
        board.instance_variable_set(:@arr, [["O","O","X"],
                                            ["O","X","O"],
                                            ["O","X","O"]])
      end

      it 'returns true' do
        expect(board.consecutive_three?("X")).to be false
        expect(board.consecutive_three?("O")).to be true
      end
    end
  end

  describe '#valid_move?' do

    context 'valid' do
      it 'returns true' do
        expect(board.valid_move?(0,0)).to be true
      end
    end

    context 'not valid, out of bounds' do
      it 'returns false' do
        expect(board.valid_move?(3,0)).to be false
      end
      
    end

    context 'not valid, chosen square not empty' do
      before do
        board.instance_variable_set(:@arr, [[" "," "," "],
                                            [" ","X"," "],
                                            [" "," "," "]])
      end
      it 'returns false' do
        expect(board.valid_move?(1,1)).to be false
      end
    end
  end
end