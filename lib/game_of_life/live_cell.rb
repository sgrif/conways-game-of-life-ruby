require 'singleton'

class GameOfLife
  class LiveCell
    include Singleton

    def to_s
      'o'
    end

    def alive?
      true
    end

    def survives?(neighbor_count)
      (2..3).cover?(neighbor_count)
    end
  end
end
