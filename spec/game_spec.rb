require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'


describe Game do

  describe '#play' do
    subject(:game_over) {described_class.new()}

    context 'game over' do
      
      before do
       allow(game_over).to receive(:game_over?).and_return(true)
      #  allow(game_over).to receive(:puts).and_return(nil)
      end

      it "doesn't enter the loop" do
        # game_over.instance_variable_set(:@board, [['X', 'X', 'X'],['O' 'X' 'O'], ['O' 'X' 'O']]) 
        expect(game_over).to_not receive(:process_input)
        expect {game_over.play}.to change{game_over.instance_variable_get(:@turn)}.by(0)
        # game_over.play
      end
    end

    context 'not game over' do
      before do
        allow(game_over).to receive(:game_over?).and_return(false, true)
      end

      it "enters the loop" do
        expect(game_over).to receive(:process_input)
        expect {game_over.play}.to change{game_over.instance_variable_get(:@turn)}.by(1)
      end
    end
  end

  describe '#process_input' do

    subject(:game_input) { described_class.new()}
    let(:player) {instance_double(Player, symbol: 'X')}
    # let(:board) {instance_double(Board)}

    context "valid input" do
      before do
        valid_input = "1,1"
        allow(game_input).to receive(:gets).and_return(valid_input)
        allow(player).to receive(:to_s).and_return("Player 1")
        allow(player).to receive(:symbol).and_return("X")
        # allow(board).to receive(:to_s).and_return("STUB BOARD")
        # allow(board).to receive(:add_to_board).and_return(true)
        allow(game_input).to receive(:move).and_return(true)
      end

      it "enters the loop" do
        game_input.instance_variable_set(:@player_one, player)
        # game_input.instance_variable_set(:@board, board)
        expect(game_input).to receive(:print).once
        expect(game_input).to receive(:move).once
        game_input.process_input(player)
      end
    end

    context "invalid, then valid input" do
      before do
        invalid_input = "3,4"
        valid_input = "1,1"
        allow(game_input).to receive(:gets).and_return(invalid_input, valid_input)
        allow(player).to receive(:to_s).and_return("Player 1")
        allow(player).to receive(:symbol).and_return("X")
        allow(game_input).to receive(:move).and_return(true)
      end

      it "enters the loop twice" do
        game_input.instance_variable_set(:@player_one, player)
        expect(game_input).to receive(:print).twice
        expect(game_input).to receive(:move).once
        game_input.process_input(player)
      end
    end



  end

  describe '#game_over?' do

    subject(:game_over) {described_class.new}
    let(:board) {instance_double(Board)}

    context "player 1 wins" do
      before do
        allow(board).to receive(:consecutive_three?).with("X").and_return(true)
        allow(board).to receive(:consecutive_three?).with("O").and_return(false)
        allow(board).to receive(:board_full?).and_return(false)
      end

      it "returns true" do
        expect(board).to receive(:consecutive_three?).once
        expect(board).not_to receive(:board_full?)
        game_over.instance_variable_set(:@board, board)
        is_over = game_over.game_over?
        expect(is_over).to be true
        
      end
    end

    context "player 2 wins" do
      before do
        allow(board).to receive(:consecutive_three?).with("X").and_return(false)
        allow(board).to receive(:consecutive_three?).with("O").and_return(true)
        allow(board).to receive(:board_full?).and_return(false)
      end

      it "returns true" do
        expect(board).to receive(:consecutive_three?).twice
        expect(board).not_to receive(:board_full?)
        game_over.instance_variable_set(:@board, board)
        is_over = game_over.game_over?
        expect(is_over).to be true
      end

    end

    context "draw" do
      before do
        allow(board).to receive(:consecutive_three?).with("X").and_return(false)
        allow(board).to receive(:consecutive_three?).with("O").and_return(false)
        allow(board).to receive(:board_full?).and_return(true)
      end

      it "returns true" do
        expect(board).to receive(:consecutive_three?).twice
        expect(board).to receive(:board_full?)
        game_over.instance_variable_set(:@board, board)
        is_over = game_over.game_over?
        expect(is_over).to be true
      end

    end
  end

  describe '#get_winner' do
    subject(:game_winner) {described_class.new}
    let(:board) {instance_double(Board)}

    context "player 1 wins" do
      before do
        allow(board).to receive(:consecutive_three?).with("X").and_return(true)
        allow(board).to receive(:consecutive_three?).with("O").and_return(false)
        allow(board).to receive(:board_full?).and_return(false)
      end

      it "returns 'player 1 wins!'" do
        expect(board).to receive(:consecutive_three?).once
        game_winner.instance_variable_set(:@board, board)
  
        winning_message = "player 1 wins!"
        result = game_winner.get_winner
        expect(result).to eq(winning_message)
        
      end
    end

    context "player 2 wins" do
      before do
        allow(board).to receive(:consecutive_three?).with("X").and_return(false)
        allow(board).to receive(:consecutive_three?).with("O").and_return(true)
        allow(board).to receive(:board_full?).and_return(false)
      end

      it "returns 'player 2 wins!'" do
        expect(board).to receive(:consecutive_three?).twice
        game_winner.instance_variable_set(:@board, board)
        
        winning_message = "player 2 wins!"
        result = game_winner.get_winner
        expect(result).to eq(winning_message)
      end

    end

    context "draw" do
      before do
        allow(board).to receive(:consecutive_three?).with("X").and_return(false)
        allow(board).to receive(:consecutive_three?).with("O").and_return(false)
        allow(board).to receive(:board_full?).and_return(true)
      end

      it "returns 'Draw!'" do
        expect(board).to receive(:consecutive_three?).twice
        game_winner.instance_variable_set(:@board, board)
        
        winning_message = "Draw!"
        result = game_winner.get_winner
        expect(result).to eq(winning_message)
      end

    end
    
  end

  describe '#move' do

    subject(:game_board) {described_class.new}
    let(:board) {instance_double(Board)}
    let(:player) {instance_double(Player, symbol: 'X')}
    
    before do
      allow(board).to receive(:add_to_board)
    end

    it "calls add_to_board" do
      game_board.instance_variable_set(:@board, board)
      expect(board).to receive(:add_to_board)
      game_board.move(1,2,player)
      
    end
  end


end
