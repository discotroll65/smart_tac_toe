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
    end

    def switch_turn
      self.players = [self.players[1], self.players[0]]
    end

  end
end
