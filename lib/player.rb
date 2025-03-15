require_relative 'board'

class Player
  attr_reader :choice, :name
  attr_accessor :score

  def initialize(name, choice)
    @name = name
    @choice = choice
    @score = 0
  end

  def play(coordinates)
    Board.pass_state[Board.coordinate_to_index(coordinates)] = choice # update state of the board
  end
end
