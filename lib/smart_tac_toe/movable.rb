module SmartTacToe
  module Movable

    def move_valid?(move,board = self.board)
      result = true
      coordinate_array = board.convert_move_to_coords(move)

      board_spot = board.get_cell(coordinate_array[0],coordinate_array[1]) if coordinate_array != nil

      result = false if board_spot != move
      result
    end

  end
end
