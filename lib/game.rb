require_relative 'user_interaction'
require_relative 'player'
require_relative 'board'
class Game
  attr_accessor :turn, :result, :current_round
  attr_reader :player1, :player2, :rounds

  include UserInteraction

  def initialize
    @player1 = Player.new(get_user_name, get_user_choice)
    @player2 = Player.new(get_user_name, player2_choice)
    @turn = 0
    @rounds = get_rounds
    @current_round = 0
    @result = ''
  end

  def check_rows(state)
    row = []
    state.each do |element|
      row << element
      next unless row.length == 3
      return 1 if row.all?('X') || row.all?('O')

      row = []
    end
  end

  def check_columns(state)
    column = []
    sort_by_column = []
    state.each_with_index do |element, index|
      sort_by_column << [element, index]
    end

    sort_by_column.sort_by! { |element| element[1] % 3 }

    sort_by_column.each do |element|
      column << element[0]
      next unless column.length == 3
      return 1 if column.all?('X') || column.all?('O')

      column = []
    end
  end

  def check_diagonal(state)
    first_diagonal = [0, 4, 8].map { |element| state[element] }
    second_diagonal = [2, 4, 6].map { |element| state[element] }

    return 1 if first_diagonal.all?('X') || first_diagonal.all?('O')

    return 1 if second_diagonal.all?('X') || second_diagonal.all?('O')
  end

  def check_result
    if check_columns(Board.pass_state) == 1 ||
       check_rows(Board.pass_state) == 1 ||
       check_diagonal(Board.pass_state) == 1
      self.result = 'win'
      if turn.even?
        player1.score += 1
      else
        player2.score += 1
      end
    elsif turn == 8
      self.result = 'tie'
    end
  end

  def reset_turn
    Board.change_state = Array.new(9, '')
    self.turn = 0
    self.result = ''
  end

  def start_turn
    while result != 'win' && result != 'tie'
      player1.play(get_move)
      puts "turn: #{turn}"
      puts "#{player1.name}:"
      Board.render
      check_result
      self.turn += 1
      break if %w[win tie].include?(result)

      player2.play(get_move)
      puts "turn: #{turn}"
      puts "#{player2.name}:"
      Board.render
      check_result
      self.turn += 1
    end
    show_score
    self.current_round += 1
  end

  def start
    while rounds != current_round
      start_turn
      reset_turn
    end
  end
end
