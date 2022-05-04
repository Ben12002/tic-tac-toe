require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'


describe Game do

  subject(:game){ described_class.new }

  before do
    game.instance_variable_set(:@board, instance_double(Board))
  end
  

  describe '#create_character' do

    context 'create character 1' do

      before do
        valid_input = 'X'
        allow(game).to receive(:get_symbol_input).and_return(valid_input)
      end

      it 'calls Player.new with valid_symbol and 1' do   
        expect(Player).to receive(:new).with('X', 1)
        game.create_character(1)
      end
    end

    # This really is testing the logic of #get_symbol_input, not create_character.
    #-----------------------------------------------------------------------------------
    # context 'create character 1, invalid input' do
    #   before do
    #     invalid_input = 'ab'
    #     allow(game).to receive(:gets).and_return(invalid_input)
    #     allow(game).to receive(:get_symbol_input)
    #   end

    #   it 'does not call Player.new' do   
    #     expect(Player).not_to receive(:new).with('ab', 1)
    #     game.create_character(1)
    #   end
    # end
    #-----------------------------------------------------------------------------------

    context 'create character 2' do
      before do
        symbol_one = 'X'
        valid_input = 'O'
        game.instance_variable_set(:@player_one, instance_double(Player, num: 1, symbol: symbol_one))
        allow(game).to receive(:get_symbol_input).and_return(valid_input)
      end

      it 'calls Player.new with valid_symbol and 2' do   
        expect(Player).to receive(:new).with('O', 2)
        game.create_character(2)
      end
      
    end

    # This really is testing the logic of #get_symbol_input, not create_character.
    #-----------------------------------------------------------------------------------
    # context 'create character 2, invalid input' do
    # end
    #-----------------------------------------------------------------------------------

    # If we don't have the valid input afterwards, the program would get stuck in an infinite loop...
    context 'create character 2, identical to character 1, then valid input' do
      before do
        symbol_one = 'X'
        valid_input = 'O'
        game.instance_variable_set(:@player_one, instance_double(Player, num: 1, symbol: symbol_one))
        allow(game).to receive(:get_symbol_input).and_return(symbol_one,valid_input)
      end

      it 'asks the user to enter a different character' do
        expect(game).to receive(:puts).with("please choose a different character: ").once
        expect(Player).to receive(:new).with('O', 2)
        game.create_character(2)
      end
    end
  end


  describe '#get_move_input' do

    context 'valid move' do
      before do
        allow().to receive(:gets).and_return()
      end
    end

    context 'invalid move, then valid move' do
      before do
        allow(game).to receive(:gets).and_return()
      end
    end

    #  These tests are testing the logic of board.valid_move, not get_move_input.
    #-----------------------------------------------------------------------------------
    # context 'invalid input, wrong format. Then valid input' do
    # end

    # context 'invalid input, out of bounds. Then valid input' do
    # end
    #-----------------------------------------------------------------------------------

  end


  describe '#get_symbol_input' do

    context 'valid input' do
      before do
        valid_input = "X"
        allow(game).to receive(:gets).and_return(valid_input)
      end

      it 'returns the input' do
        result = game.get_symbol_input
        expect(result).to eq("X")
      end
    end

    context 'invalid input, more than 1 character' do
      before do
        invalid_input = "ab"
        valid_input = "a"
        allow(game).to receive(:gets).and_return(invalid_input,valid_input)
      end

      it 'outputs an error message once, then returns the valid input' do
        expect(game).to receive(:puts).with("Please enter only one character.").once
        result = game.get_symbol_input
        expect(result).to eq("a")
      end
    end
  end
  

  describe '#game_over?' do

    before do
      game.instance_variable_set(:@player_one, instance_double(Player, symbol: 'X', num: 1))
      game.instance_variable_set(:@player_two, instance_double(Player, symbol: 'O', num: 2))
    end

    context 'player one wins' do
      before do
        allow(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(true)
        allow(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(false)
        allow(game.board).to receive(:board_full?).and_return(false)
      end

      it 'returns true' do
        expect(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(true)
        expect(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(false)
        expect(game.board).to receive(:board_full?).and_return(false)
        
        result = game.game_over?
        expect(result).to be true
      end

    end

    context 'player two wins' do
      before do
        allow(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(true)
        allow(game.board).to receive(:board_full?).and_return(false)
      end

      it 'returns true' do
        expect(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        expect(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(true)
        expect(game.board).to receive(:board_full?).and_return(false)

        result = game.game_over?
        expect(result).to be true
      end
    end

    context 'draw' do
      before do
        allow(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(false)
        allow(game.board).to receive(:board_full?).and_return(true)
      end

      it 'returns true' do
        expect(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        expect(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(false)
        expect(game.board).to receive(:board_full?).and_return(true)

        result = game.game_over?
        expect(result).to be true
      end
    end

    context 'not game over' do
      before do
        allow(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(false)
        allow(game.board).to receive(:board_full?).and_return(false)
      end

      it 'returns false' do
        expect(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        expect(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(false)
        expect(game.board).to receive(:board_full?).and_return(false)

        result = game.game_over?
        expect(result).to be false
      end
    end
  end

  
  describe '#get_winner' do

    before do
      game.instance_variable_set(:@player_one, instance_double(Player, symbol: 'X', num: 1))
      game.instance_variable_set(:@player_two, instance_double(Player, symbol: 'O', num: 2))
    end

    context 'player one wins' do
      before do
        allow(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(true)
      end

      it 'returns player 1 win string' do
        expect(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(true)
        
        result = game.get_winner
        expect(result).to eq('player 1 wins!')
        
      end
        
    end

    context 'player two wins' do
      before do
        allow(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(true)
      end

      it 'returns player 1 win string' do
        expect(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(true)
        
        result = game.get_winner
        expect(result).to eq('player 2 wins!')
        
      end
    end

    context 'draw' do
      before do
        allow(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(false)
      end

      it 'returns player 1 win string' do
        expect(game.board).to receive(:consecutive_three?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_three?).with(game.player_two.symbol).and_return(false)
        
        result = game.get_winner
        expect(result).to eq('Draw!')
        
      end
    end
  end


  describe '#move' do

    before do
      game.instance_variable_set(:@player_one, instance_double(Player, symbol: 'X', num: 1))
    end
    it 'calls add_to_board on @board' do
      expect(game.board).to receive(:add_to_board).with(1,1,'X')
      expect(game.player_one).to receive(:symbol)
      game.move(1,1,game.player_one)
    end
  end
end
