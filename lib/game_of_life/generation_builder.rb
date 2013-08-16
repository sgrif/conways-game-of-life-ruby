class GameOfLife
  class GenerationBuilder
    def initialize(board, board_builder_factory = BoardBuilder)
      @board = board
      @board_builder_factory = board_builder_factory
    end

    def next_board
      board.each_cell do |cell, x, y|
        if cell.survives?(neighbors_count(x, y))
          board_builder.place_live_cell(x, y)
        else
          board_builder.place_dead_cell(x, y)
        end
      end
      board_builder.board
    end

    def neighbors_count(x, y)
      coords = [[x-1, y-1], [x, y-1], [x+1, y-1],
                [x-1, y],             [x+1, y],
                [x-1, y+1], [x, y+1], [x+1, y+1]]
      coords.map{ |pair| board.cell_at(*pair) }
        .reject(&:nil?)
        .select(&:alive?)
        .size
    end

    private

    attr_reader :board, :board_builder_factory

    def board_builder
      @board_builder ||= board_builder_factory.new
    end
  end
end
