require 'fast_spec_helper'
require 'game_of_life/game'

class GameOfLife
  describe Game do
    describe '#tick' do
      it 'advances the generation' do
        next_board = double('next board')
        board = double('board')
        generation_factory = double(new: double(next_board: next_board))
        game = Game.new(board, generation_factory)

        game.tick

        expect(generation_factory).to have_received(:new).with(board)
        expect(game.board).to eq(next_board)
      end
    end
  end
end
