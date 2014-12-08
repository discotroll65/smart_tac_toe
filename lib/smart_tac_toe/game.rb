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

      self.computer_game(choice)
      puts"\n\n\n\n"
    end

    def computer_game(choice)
      coinflip = [-1,1].sample
      player_flag = -1*coinflip

      puts
      puts
      if player_flag == -1 && choice == "2"
        puts"HAL 2014 has randomly been chosen to go first"
      end

      while true
        if player_flag == 1 || choice == "1"
          board.terminal_display
          puts
          puts "#{current_marker}'s turn. Enter your move:"
          print ">>"

          move = gets.strip
          enter_terminal(move)

        else
          hal_turn
        end

        break if board.game_won? || board.game_tied?
        player_flag *= -1
        switch_turn
      end
      
        board.terminal_display
        puts "Game Over!"
        puts "#{current_marker} wins!" if board.game_won?
        puts "Cat's Game!" if board.game_tied?
        puts "~~~~~~~~~~~~~~~~~~~~"
    end

    def hal_turn
      if players[0].about_to_win?(board,players[0].marker)[:answer]
        players[0].fill_pending_win(board, players[0].marker)
      elsif players[0].about_to_win?(board,players[1].marker)[:answer]
        players[0].fill_pending_win(board, players[1].marker)
      elsif board.available_board_moves.size == 9
        hal_move = board.available_board_moves.sample
        board.fill_cell_from_move(hal_move,players[0].marker)
      else

        optimal_moves = players[0].knockout_moves(board)

        if optimal_moves.size > 0
          hal_move = optimal_moves.sample
        else
          crappy_moves = []
          crappy_moves = players[0].losing_moves(board) if board.available_board_moves.size >=3
          moves_considering = board.available_board_moves - crappy_moves
          hal_move = moves_considering.sample
        end
        board.fill_cell_from_move(hal_move, players[0].marker)
      end
      puts "HAL 2014 has made its move"
    end

    def enter_terminal(move)
      move = handle_terminal(move)
      board.fill_cell_from_move(move,current_marker)
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
