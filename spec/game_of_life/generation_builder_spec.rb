require 'fast_spec_helper'
require 'game_of_life/generation_builder'

class GameOfLife
  describe GenerationBuilder do
    describe '#next_board' do
      let(:board_builder) { double(board: nil, place_live_cell: nil, place_dead_cell: nil) }
      let(:board_builder_factory) { double(new: board_builder) }
      let(:board) { double(each_cell: nil) }
      let(:generation_builder) { GenerationBuilder.new(board, board_builder_factory) }

      it 'creates a board with the next generation' do
        generation_builder.next_board

        expect(board).to have_received(:each_cell)
        expect(board_builder).to have_received(:board)
      end

      it 'places live tiles where cells survive' do
        cell = double(survives?: true)
        allow(board).to receive(:each_cell).and_yield(cell, 0, 1)
        allow(board).to receive(:cell_at).and_return(nil)

        generation_builder.next_board

        expect(cell).to have_received(:survives?).with(0)
        expect(board_builder).to have_received(:place_live_cell).with(0, 1)
      end

      it 'places dead tiles where cells die' do
        cell = double(survives?: false)
        allow(board).to receive(:each_cell).and_yield(cell, 1, 0)
        allow(board).to receive(:cell_at).and_return(nil)

        generation_builder.next_board

        expect(board_builder).to have_received(:place_dead_cell).with(1, 0)
        expect(board_builder).not_to have_received(:place_live_cell)
      end
    end

    describe '#neighbors_count' do
      it 'counts the number of living neighbors for an x,y pair' do
        board = double('board')
        dead_cell = double(alive?: false)
        live_cell = double(alive?: true)

        expect(board).to receive(:cell_at).with(-1, -1).and_return(nil)
        expect(board).to receive(:cell_at).with(-1, 0).and_return(nil)
        expect(board).to receive(:cell_at).with(-1, 1).and_return(nil)
        expect(board).to receive(:cell_at).with(0, -1).and_return(nil)
        expect(board).not_to receive(:cell_at).with(0, 0)
        expect(board).to receive(:cell_at).with(0, 1).and_return(live_cell)
        expect(board).to receive(:cell_at).with(1, -1).and_return(nil)
        expect(board).to receive(:cell_at).with(1, 0).and_return(dead_cell)
        expect(board).to receive(:cell_at).with(1, 1).and_return(live_cell)

        generation_builder = GenerationBuilder.new(board, double)
        count = generation_builder.neighbors_count(0, 0)

        expect(count).to eq(2)
      end
    end
  end
end
