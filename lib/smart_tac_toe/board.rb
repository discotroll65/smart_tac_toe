require_relative "./movable.rb"
require_relative "./strategic.rb"

module SmartTacToe
  class Board
    include Strategic

    attr_accessor :grid
    def initialize (input = Board.default)
      @grid = input
    end

    def get_cell (row, col)
      cell = grid[row][col]
      cell.value
    end

    def fill_cell (row, col, input)
      cell = grid[row][col]
      cell.value = input
    end

    def fill_cell_from_move(move, input)
      grid_coords = convert_move_to_coords(move)
      fill_cell(grid_coords[0],grid_coords[1],input)
    end

    def diagonals
      [  [ grid[0][0],grid[1][1],grid[2][2] ] ,  [  grid[0][2],grid[1][1],grid[2][0]  ]  ]
    end

    def win_combos
      grid + grid.transpose + diagonals
    end

    def available_winning_combos
      combo_indices = []

      win_combos.each_with_index do |combo, index|
        unless combo_dead?(combo)
          combo_indices << index
        end
      end

      available_combos = combo_mapper(combo_indices)
      available_combos

    end

    def combo_win? (cell_combo)
      result = cell_combo.map {|square| square.value}      
      result.uniq.length == 1 && result[0] != ""
    end

    def game_won?
      result = false

      win_combos.each do |combo|
        if combo_win?(combo)
          result = true
          break
        end
      end
      result

    end

    def terminal_display
      grid.each do |row|
        puts " #{row[0].value} | #{row[1].value} | #{row[2].value}"
        puts "===+===+==="
      end
    end

    def game_tied?
      result = true
      result = false if available_board_moves.size != 0 || self.game_won?
      result
    end

    def array_of_combo_values(combo_of_cells)
      combo_of_cells.map {|cell| cell.value }
    end

    def available_board_moves
      move_array = []

      grid.each do |row|
        free_row_cells = available_combo_moves(row)
        free_row_cells.each {|cell| move_array << cell}
      end

      move_array
    end

    def combo_mapper(combo_indices)
      combo_map_hash = {
        0 => ["1","2","3"],
        1 => ["4","5","6"],
        2 => ["7","8","9"],
        3 => ["1","4","7"],
        4 => ["2","5","8"],
        5 => ["3","6","9"],
        6 => ["1","5","9"],
        7 => ["3","5","7"]
      }
      available_combos = []
      combo_indices.each do |combo_index|
        available_combos << combo_map_hash[combo_index]
      end
      available_combos
    end

    def available_combo_moves(combo)
      all_moves = (1..9).to_a.map {|move| move.to_s}
      move_array = []
      combo.each do |square|
        union =  ([square.value] & all_moves) 
        if union != []
          move_array << union[0]
        end
      end
      move_array
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

private
    def self.default
      default_grid = Array.new(3) {Array.new(3) {Cell.new} }
      num = 1

      default_grid.each do |row|
        row.each do |square|
          square.value = num.to_s
          num += 1
        end
      end
    end

  end
end


