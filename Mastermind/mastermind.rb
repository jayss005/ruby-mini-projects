class Game
  def initialize(code, player)  
    @code = code
    @player = player
    @attempts = 12
    @history = []
  end

  def play
    puts "Welcome to Mastermind!"
    puts "The secret code has been generated. You have #{@attempts} attempts to guess it."
    puts "Available colors: #{Code::COLORS.join(', ')}"


    @attempts.times do |attempt|
      puts "\nAttempt #{attempt + 1}/#{@attempts}:"
      guess = @player.guess
      feedback = @code.check_guess(guess)
      @history << { guess: guess, feedback: feedback }

      if feedback[:correct_position] == @code.secret_code.length
        puts "Congratulations! You've guessed the secret code in #{attempt + 1} attempt(s)!"
        return
      else
        puts "Feedback: #{feedback[:correct_position]} correct position(s), #{feedback[:correct_color]} correct color(s)"
      end
    end

    puts "\nGame over! The secret code was: #{@code.secret_code.join(', ')}"
  end

  def play_again?
    puts "\nPlay again? (y/n)"
    answer = gets.chomp.downcase
    answer == "y"
  end
end


class Code
  COLORS = ['R', 'G', 'B', 'Y', 'O', 'P']
  attr_reader :secret_code

  def initialize
    @secret_code = Array.new(4) { COLORS.sample }
  end

  def check_guess(guess)
    secret_copy = @secret_code.dup
    guess_copy = guess.dup

    correct_position = 0
    correct_color = 0

    # First pass: check for correct position
    guess_copy.each_with_index do |color, index|
      if color == secret_copy[index]
        correct_position += 1
        secret_copy[index] = nil
        guess_copy[index] = nil
      end
    end

    # Second pass: check for correct color, wrong position
    guess_copy.each do |color|
      next if color.nil?

      if secret_copy.include?(color)
        correct_color += 1
        secret_copy[secret_copy.index(color)] = nil
      end
    end


    {
      correct_position: correct_position,
      correct_color: correct_color,
    }
  end
end


class Player
  def guess
    loop do
      puts "Enter your guess (4 colors from #{Code::COLORS.join(', ')}, e.g. RGBY):"
      input = gets.chomp.upcase.chars

      if input.length == 4 && input.all? { |c| Code::COLORS.include?(c) }
        return input
      else
        puts "Invalid guess. Please enter exactly 4 colors using: #{Code::COLORS.join(', ')}."
      end
    end
  end
end


loop do
  code = Code.new
  player = Player.new
  game = Game.new(code, player)
  game.play
  break unless game.play_again?
end