module SmartTacToe
  class Game
    attr_reader :players
    def initialize( player1 = HumanPlayer.new, player2 = HumanPlayer.new )
      player1.marker = "X"
      player2.marker = "O"

      @players = [player1, player2]
    end

    def convert_move_to_coords
      
    end
    
    def play_in_console
      board = Board.new
      puts "Welcome to Tic Tac Toe!"
      puts "Choose your opponent:"
      puts "Human: 1"
      puts "HAL 2014: 2"
      print ">>"

      choice = gets.strip

      return "HAL must first be built!" if choice == "2"

      board.terminal_display
      puts "#{players[0].marker}'s turn. Enter your move:"
      print ">>"

      move = gets.strip

      input = convert_move_to_coords

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
  end
end
