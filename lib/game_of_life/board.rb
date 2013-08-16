class GameOfLife
  class Board
    def initialize(cells)
      @cells = cells
    end

    def to_s
      cells.map do |row|
        row.map(&:to_s).join(' ')
      end.join("\n")
    end

    def each_cell
      cells.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          yield cell, x, y
        end
      end
    end

    def cell_at(x, y)
      if x < 0 || y < 0
        nil
      else
        row = cells[y] || []
        row[x]
      end
    end

    private

    attr_reader :cells
  end
end
