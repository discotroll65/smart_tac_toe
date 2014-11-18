require_relative "./movable.rb"
module SmartTacToe
  class Game
    include Movable
    attr_reader :board
    attr_accessor :players
    def initialize( player1 = Player.new, player2 = Player.new )
      player1.marker = "X"
      player2.marker = "O"

      @players = [player1, player2]
      @current_marker = current_marker
      @board = Board.new
    end

    def current_marker
      players[0].marker
    end

    def play_in_console
      puts "Welcome to Tic Tac Toe!"
      puts "Choose your opponent:"
      puts "Human: 1"
      puts "HAL 2014: 2"
      print ">>"

      choice = gets.strip

      if choice == "2"
        puts "HAL must first be built!" 
        return 
      end
      puts"\n\n\n\n"

      while true

        board.terminal_display
        puts
        puts "#{current_marker}'s turn. Enter your move:"
        print ">>"

        move = gets.strip

        enter_terminal(move)

        break if board.game_won? || board.game_tied?
        switch_turn
      end

      board.terminal_display
      puts "Game Over!"
      puts "#{current_marker} wins!" if board.game_won?
      puts "Cat's Game!" if board.game_tied?
      puts "~~~~~~~~~~~~~~~~~~~~"

    end

    def enter_terminal(move)
      move = handle_terminal(move)
      board.fill_cell_from_move(move)
   end

    def handle_terminal(move)
      while !move_valid?(move)
        board.terminal_display
        puts "Sorry, not a valid move!"
        puts "#{current_marker}, please enter your move again, 1-9"
        print ">>"
        move = gets.strip
      end
      move
    end

    def switch_turn
      self.players = [self.players[1], self.players[0]]
    end
  end
end
