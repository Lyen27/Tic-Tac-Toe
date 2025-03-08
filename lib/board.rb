
class Board
  @@game_state = Array.new(9, "")
  def self.pass_state
    @@game_state
  end

  def self.coordinate_to_index(coordinate)
    converter = %w[1,1 1,2 1,3 2,1 2,2 2,3 3,1 3,2 3,3]
    converter.index(coordinate)
  end

  def self.render
    grid_generator = '|_1_|'
    line = ''
    self.pass_state.each_with_index do |state, index|
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


