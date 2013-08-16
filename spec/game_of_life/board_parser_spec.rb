require 'fast_spec_helper'
require 'game_of_life/board_parser'

class GameOfLife
  describe BoardParser do
    let(:board_builder) { double(place_live_cell: nil, place_dead_cell: nil, board: nil) }
    class BoardBuilder; end

    context '#board' do
      it "creates a cell for each character in the given string" do
        board_string = "..\n.."

        parse_string(board_string)

        expect(board_builder).to have_received(:place_dead_cell).exactly(4).times
        expect(board_builder).to have_received(:board)
      end

      it "parses 'o' as live cells and '.' as dead" do
        board_string = ".o\n.."

        parse_string(board_string)

        expect(board_builder).to have_received(:place_dead_cell).with(0, 0)
        expect(board_builder).to have_received(:place_live_cell).with(1, 0)
        expect(board_builder).to have_received(:place_dead_cell).with(0, 1)
        expect(board_builder).to have_received(:place_dead_cell).with(1, 1)
      end

      it "raises an ArgumentError for other characters" do
        expect { parse_string("wibble") }.to raise_exception(ArgumentError)
      end

      def parse_string(board_string)
        board_parser = BoardParser.new(board_string, double(new: board_builder))

        board_parser.board
      end
    end

    context '#lines' do
      it 'strips whitespace from the lines' do
        parser = BoardParser.new("foo\nbar")

        expect(parser.lines).to eq(["foo", "bar"])
      end
    end
  end
end
