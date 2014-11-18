module SmartTacToe
  module Movable

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

    def move_valid?(move,board = self.board)
      result = true
      coordinate_array = convert_move_to_coords(move) #in Movable module

      board_spot = board.get_cell(coordinate_array[0],coordinate_array[1]) if coordinate_array != nil

      result = false if board_spot != move
      result
    end

  end
end
