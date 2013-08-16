class GameOfLife
  class BoardParser
    def initialize(board_string, builder_factory = BoardBuilder)
      @board_string = board_string
      @builder_factory = builder_factory
    end

    def board
      lines.each_with_index do |line, y|
        parse_line(line, y)
      end
      builder.board
    end

    def lines
      board_string.lines.map(&:rstrip)
    end

    private

    def parse_line(line, y)
      line.split(' ').each_with_index do |char, x|
        parse_character(char, x, y)
      end
    end

    def parse_character(char, x, y)
      case char
      when "o" then builder.place_live_cell(x, y)
      when "." then builder.place_dead_cell(x, y)
      else raise ArgumentError.new("Unrecognized character #{char}")
      end
    end

    def builder
      @builder ||= builder_factory.new
    end

    attr_reader :board_string, :builder_factory
  end
end
