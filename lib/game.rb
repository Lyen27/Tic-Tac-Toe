require_relative 'user_interaction'
require_relative 'player'
require_relative 'board'
class Game 
  attr_accessor :turn, :result, :current_round
  attr_reader :player_1, :player_2, :rounds
  
  
  include UserInteraction
  
  def initialize
    @player_1 = Player.new(get_user_name, get_user_choice)
    @player_2 = Player.new(get_user_name, player2_choice)
    @turn = 0
    @rounds = get_rounds
    @current_round = 0
    @result = ''
  end

  def check_rows(state)
    row = []
    state.each do |element|
      row << element
      if row.length == 3
        if row.all? {|element| element == 'X'} || row.all? {|element| element == 'O'}
          return 1
        end
        row = []
      end
    end
  end

  def check_columns(state)
    column = []
    sort_by_column = []
    state.each_with_index do |element, index|
      sort_by_column << [element,index]
    end

    sort_by_column.sort_by! {|element| element[1] % 3}
    
    sort_by_column.each do |element|
      column << element[0]
      if column.length == 3
        if column.all? {|element| element == 'X'} || column.all? {|element| element == 'O'}
          return 1
        end
        column = []
      end
    end
  end

  def check_diagonal(state)
    first_diagonal = [0,4,8].map {|element| state[element]}
    second_diagonal = [2,4,6].map {|element| state[element]}

    if first_diagonal.all? {|element| element == 'X'} || first_diagonal.all? {|element| element == 'O'}
      return 1
    end 

    if second_diagonal.all? {|element| element == 'X'} || second_diagonal.all? {|element| element == 'O'}
      return 1
    end 
  end

  def check_result
    if check_columns(Board.pass_state) == 1 ||
      check_rows(Board.pass_state) == 1 ||
      check_diagonal(Board.pass_state) == 1
        self.result = 'win'
        if turn % 2 == 0
          player_1.score += 1
        else
          player_2.score += 1
        end
    else
      if turn == 8
        self.result = 'tie'
      end
    end
  end

  def reset_turn
    Board.change_state = Array.new(9, "")
    self.turn = 0
    self.result = ''
  end

  def start_turn
    while result != 'win' && result != 'tie'
      player_1.play(get_move)
      puts "turn: #{turn}"
      puts "#{player_1.name}:"
      Board.render
      check_result
      self.turn += 1
      if result == 'win' || result == 'tie'
        break
      end
      
      player_2.play(get_move)
      puts "turn: #{turn}"
      puts "#{player_2.name}:"
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