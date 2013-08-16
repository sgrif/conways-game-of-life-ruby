require 'fast_spec_helper'
require 'game_of_life/board'

class GameOfLife
  describe Board do
    describe '#to_s' do
      it "returns each of it's cells as a grid" do
        live = double(to_s: 'o')
        dead = double(to_s: '.')

        board = Board.new([[live, dead], [dead, live]])

        expect(board.to_s).to eq("o .\n. o")
      end
    end

    describe '#each_cell' do
      it 'yields each cell with its x and y' do
        first_cell = double('first cell')
        second_cell = double('second cell')
        board = Board.new([[first_cell], [second_cell]])

        expected = [[first_cell, 0, 0], [second_cell, 0, 1]]
        expect { |p| board.each_cell(&p) }.to yield_successive_args(*expected)
      end
    end

    describe '#cell_at' do
      it 'returns the cell at the given coordinates' do
        first_cell = double('first cell')
        second_cell = double('second cell')

        board = Board.new([[first_cell], [second_cell]])

        expect(board.cell_at(0, 0)).to eq(first_cell)
        expect(board.cell_at(0, 1)).to eq(second_cell)
      end

      it 'returns nil if x or y are outside the bounds' do
        board = Board.new([[double]])

        expect(board.cell_at(-1, 0)).to be_nil
        expect(board.cell_at(0, -1)).to be_nil
        expect(board.cell_at(1, 0)).to be_nil
        expect(board.cell_at(0, 1)).to be_nil
      end
    end
  end
end
