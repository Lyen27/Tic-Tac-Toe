module UserInteraction
  def get_user_name
    puts 'tell me your name'
    gets.chomp
  end

  def get_user_choice
    puts 'choose between X and O'
    check_for_choice(gets.chomp)
  end

  def check_for_choice(choice)
    while choice != 'X' && choice != 'O'
      puts 'invalid choice,try again'
      choice = gets.chomp
    end
    choice
  end

  def player2_choice
    case player1.choice
    when 'X'
      'O'
    when 'O'
      'X'
    end
  end

  def get_move
    puts 'play a move as in 1,1, the first being the row and the second the column'
    check_square(check_move(gets.chomp))
  end

  def check_square(square)
    while Board.pass_state[Board.coordinate_to_index(square)] != ''
      puts 'this square is already taken, try another one'
      square = gets.chomp
    end
    square
  end

  def check_move(move)
    until Board.converter.include?(move)
      puts 'invalid move, try again'
      move = gets.chomp
    end
    move
  end

  def get_rounds
    puts 'how many rounds do you want to play?'
    gets.chomp.to_i
  end

  def show_score
    puts "#{player1.name}: #{player1.score}"
    puts "#{player2.name}: #{player2.score}"
  end
end
