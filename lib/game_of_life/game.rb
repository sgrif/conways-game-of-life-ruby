class GameOfLife
  class Game
    attr_reader :board

    def initialize(board, generation_factory = GenerationBuilder)
      @board = board
      @generation_factory = generation_factory
    end

    def tick
      @board = generation_factory.new(board).next_board
      self
    end

    private

    attr_reader :generation_factory
  end
end
