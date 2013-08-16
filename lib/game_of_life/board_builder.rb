class GameOfLife
  class BoardBuilder
    def initialize(live_cell = LiveCell.instance, dead_cell = DeadCell.instance, board_factory = Board)
      @live_cell, @dead_cell, @board_factory = live_cell, dead_cell, board_factory
      @cells = []
    end

    def place_live_cell(x, y)
      place_cell(live_cell, x, y)
    end

    def place_dead_cell(x, y)
      place_cell(dead_cell, x, y)
    end

    def board
      ensure_valid_cells
      board_factory.new(cells)
    end

    private

    def place_cell(cell, x, y)
      cells[y] ||= []
      cells[y][x] = cell
    end

    def ensure_valid_cells
      max_x = cells.map(&:size).max - 1
      cells.each_with_index do |row, y|
        (0..max_x).each do |x|
          raise ArgumentError.new("Missing cell at #{x}, #{y}") if row[x].nil?
        end
      end
    end

    attr_reader :live_cell, :dead_cell, :board_factory, :cells
  end
end
