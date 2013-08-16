require 'fast_spec_helper'
require 'game_of_life/board_builder'

class GameOfLife
  describe BoardBuilder do
    let(:live_cell) { double('Live cell') }
    let(:dead_cell) { double('Dead cell') }
    let(:board_factory) { double(new: nil) }
    let(:board_builder) { BoardBuilder.new(live_cell, dead_cell, board_factory) }

    it 'passes live cells where asked' do
      board_builder.place_live_cell(0, 0)
      board_builder.place_live_cell(0, 1)
      board_builder.board

      expected_arguments = [[live_cell], [live_cell]]
      expect(board_factory).to have_received(:new).with(expected_arguments)
    end

    it 'passes dead cells where asked' do
      board_builder.place_dead_cell(0, 0)
      board_builder.place_dead_cell(1, 0)
      board_builder.board

      expected_arguments = [[dead_cell, dead_cell]]
      expect(board_factory).to have_received(:new).with(expected_arguments)
    end

    it 'raises an exception when it has insufficient information' do
      board_builder.place_dead_cell(0, 0)
      board_builder.place_dead_cell(1, 0)
      board_builder.place_dead_cell(1, 1)

      expect { board_builder.board }.to raise_exception(ArgumentError)
    end
  end
end
