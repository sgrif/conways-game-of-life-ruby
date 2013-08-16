require 'singleton'

class GameOfLife
  class DeadCell
    include Singleton

    def to_s
      '.'
    end

    def alive?
      false
    end

    def survives?(neighbor_count)
      neighbor_count == 3
    end
  end
end
