class WordLoader
    def self.load(filename)
        unless File.exist?(filename)
            puts "Dictionary file not found!"
            exit
        end
  
    File.readlines(filename)
        .map(&:chomp)
        .select { |w| w.length >= 5 && w.length <= 12 }
        .sample
  end
end

class Game
    def initialize(word, max_attempts = 20)
        @word = word
        @max_attempts = max_attempts
        @incorrect_guesses = 0
        @guessed_letters = []
    end

    def guess(letter)
        return if @guessed_letters.include?(letter)

        @guessed_letters << letter
        @incorrect_guesses += 1 unless @word.include?(letter)
    end

    def won?
        @word.chars.all? { |letter| @guessed_letters.include?(letter) }
    end

    def lost?
        @incorrect_guesses >= @max_attempts
    end

    def already_guessed?(letter)
        @guessed_letters.include?(letter)
    end

    def play
        display = Display.new
        loop do
            puts display.show_board(@word, @guessed_letters)
            puts display.show_status(@incorrect_guesses, @max_attempts, @guessed_letters, @word)

            print "Enter a letter or 'save':"
            input = gets.chomp.downcase
            
            if input == "save"
                SaveManager.save(self)
                puts "Game saved!"
                break
            end

            unless input.match?(/^[a-z]$/)
                puts "Please enter a single letter."
                 next
            end

            if already_guessed?(input)
                puts "You've already guessed that letter. Try again."
                next
            end

            
            guess(input)

            if won?
                puts display.show_result(true, @word)
                File.delete(File.join(__dir__, "save.dat")) if File.exist?(File.join(__dir__, "save.dat"))
                break
            elsif lost?
                puts display.show_result(false, @word)
                 File.delete(File.join(__dir__, "save.dat")) if File.exist?(File.join(__dir__, "save.dat"))
                break
            end
        end
    end
end


class Display
    def show_board(word,guessed_letters)
        word.chars.map { |letter| guessed_letters.include?(letter) ? letter : '_' }.join(' ')
    end

    def show_status(incorrect_guesses, max_attempts,        guessed_letters, word)
        wrong = guessed_letters.reject { |l| word.include?(l) }
        lives = max_attempts - incorrect_guesses
        "Wrong guesses: #{wrong.join(', ')}\nLives remaining: #{lives}"
    end

    def show_result(won,word)
        if won
            "Congratulations! You've guessed the word: #{word}"
        else
            "Game Over! The correct word was: #{word}"
        end
    end
end


class SaveManager
  def self.save(game, filename = "save.dat")
    File.open(filename, "wb") { |f| Marshal.dump(game, f) }
  end

  def self.load(filename = "save.dat")
    File.open(filename, "rb") { |f| Marshal.load(f) }
  end
end

loop do
    puts "Welcome to Hangman!"
    puts "1. New Game"
    puts "2. Load Saved Game"
    puts "3. Exit"
    choice = gets.chomp


    if choice == "1"
        if File.exist?("save.dat")
            puts "A saved game already exists. Overwrite it? (y/n)"
            File.delete("save.dat") if gets.chomp.downcase == "y"
        end
        word = WordLoader.load("Words.txt")
        Game.new(word).play
    elsif choice == "2"
        if File.exist?("save.dat")
            game = SaveManager.load
            game.play
        else
            puts "No saved game found!"
        end
    elsif choice == "3"
        puts "Goodbye!"
        break
    else
        puts "Invalid choice."
    end
end