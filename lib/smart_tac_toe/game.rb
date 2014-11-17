module SmartTacToe
  class Game
    attr_reader :board
    attr_accessor :players
    def initialize( player1 = HumanPlayer.new, player2 = HumanPlayer.new )
      player1.marker = "X"
      player2.marker = "O"

      @players = [player1, player2]
      @current_marker = current_marker
      @board = Board.new
    end

    def current_marker
      players[0].marker
    end

    def convert_move_to_coords
      
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
      grid_coords = convert_move_to_coords(move)
      board.fill_cell(grid_coords[0],grid_coords[1],current_marker)
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

    def move_valid?(move)
      result = true
      coordinate_array = convert_move_to_coords(move)

      board_spot = board.get_cell(coordinate_array[0],coordinate_array[1]) if coordinate_array != nil

      result = false if board_spot != move
      result
    end


    def convert_move_to_coords( move)
      mapping_hash = {
        "1" => [0,0],
        "2" => [0,1],
        "3" => [0,2],
        "4" => [1,0],
        "5" => [1,1],
        "6" => [1,2],
        "7" => [2,0],
        "8" => [2,1],
        "9" => [2,2]
      }
      mapping_hash[move]
    end

    def switch_turn
      self.players = [self.players[1], self.players[0]]
    end
  end
end
