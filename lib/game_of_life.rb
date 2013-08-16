require 'game_of_life/board'
require 'game_of_life/board_builder'
require 'game_of_life/board_parser'
require 'game_of_life/game'
require 'game_of_life/dead_cell'
require 'game_of_life/live_cell'
require 'game_of_life/generation_builder'

class GameOfLife
  def initialize(seed_board)
    @seed_board = seed_board
  end

  def run
    loop do
      puts "\e[H\e[2J"
      puts game.board
      game.tick
      sleep 0.1
    end
  end

  private

  def game
    @game ||= Game.new(board)
  end

  def board
    @board ||= BoardParser.new(seed_board).board
  end

  attr_reader :seed_board
end
