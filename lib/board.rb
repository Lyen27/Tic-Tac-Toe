class Board
  
  def self.render(game_state)
    grid_generator = '|_1_|'
    line = ''
    game_state.each_with_index do |state, index|
      if state != ''
        line += grid_generator.sub(/1/, state)
      else
        line += grid_generator.sub(/1/, '_')
      end
      if (index + 1) % 3 == 0
        puts line
        line = '' 
      end
    end
  end
end

Board.render(['O','O','X','O','X','O','O','O','X'])

