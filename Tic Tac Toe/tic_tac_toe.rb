class Board
    def initialize
    @board = Array.new(9)
    end

    WINNING_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def winner?(symbol)
        WINNING_COMBINATIONS.any? do |combo|
            combo.all? { |index| @board[index] == symbol }
        end
    end
    
    def display_board
        display = @board.map.with_index { |cell, i| cell.nil? ? (i + 1) : cell }

        puts " #{display[0]} | #{display[1]} | #{display[2]} "
        puts "-----------"
        puts " #{display[3]} | #{display[4]} | #{display[5]} "
        puts "-----------"
        puts " #{display[6]} | #{display[7]} | #{display[8]} "
    end

    def make_move(position, player)
        return false if position < 1 || position > 9
        index = position - 1
        if @board[index].nil?
            @board[index] = player
            return true
        else
            puts "Position already taken. Try again."
            return false
        end
    end

    def full?
    @board.none?(&:nil?)
    end
end   

class Player
    attr_reader :name, :symbol

    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end
end


class Game
    def initialize
        @board = Board.new
        @player1 = Player.new("Player 1", "X")
        @player2 = Player.new("Player 2", "O")
        @current_player = @player1
    end

    def switch_player
        @current_player = (@current_player == @player1) ? @player2 : @player1
    end

    def play
     loop do
        @board.display_board

        move = nil

        loop do
        puts "#{@current_player.name} (#{@current_player.symbol}), enter your move (1-9):"
        move = gets.to_i

        break if @board.make_move(move, @current_player.symbol)
        end

        if @board.winner?(@current_player.symbol)
        @board.display_board
        puts "#{@current_player.name} wins!"
        break
        end

        if @board.full?
        @board.display_board
        puts "It's a draw!"
        break
        end

        switch_player
    end
end
end


game = Game.new
game.play

